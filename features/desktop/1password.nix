{pkgs, ...}: {
  # Also requires gnome-keyring
  services.gnome.gnome-keyring.enable = true;
  programs._1password-gui = {
    enable = true;
    # Certain features, including CLI integration and system authentication support,
    # require enabling PolKit integration on some desktop environments (e.g. Plasma).
    polkitPolicyOwners = ["albarn"];
  };
}
