# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
{pkgs,...}: let jq = "${pkgs.jq}/bin/jq"; in {
  # Based on https://github.com/mbugert/tailscale-polybar-rofi/blob/master/info-tailscale.sh
  tailscale_status = pkgs.writeShellScriptBin "tailscale_status" ''
    ICON_ACTIVE="󰒘"
    ICON_ACTIVE_EXITNODE="󰴳"
    ICON_INACTIVE="󰦞"

    status=$(${pkgs.curl}/bin/curl --silent --fail --unix-socket /var/run/tailscale/tailscaled.sock http://local-tailscaled.sock/localapi/v0/status)

    # bail out if curl had non-zero exit code
    if [ $? != 0 ]; then
        exit 0
    fi

    # check if it's stopped (down)
    if [ "$(echo $status | ${jq} --raw-output .BackendState)" = "Stopped" ]; then
        echo '{ "alt": "inactive", "tooltip": "Not connected to Tailscale" }'
        exit 0
    fi

    exit_node_hostname="$(echo $status | ${jq} --raw-output '.Peer[] | select(.ExitNode) | .HostName')"
    if [ -n "$exit_node_hostname" ]; then
        echo '{ "alt": "active-exitnode", "tooltip": "Connected to Tailscale\rRouting all traffic via $exit_node_hostname" }'
    else
        echo '{ "alt": "active", "tooltip": "Connected to Tailscale" }'
    fi
  '';
}
