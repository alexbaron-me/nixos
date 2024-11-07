# Generic system configuration that is shared by all (my) machines
{pkgs, ...}: {
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";

  networking.networkmanager.enable = true;

  users.users.albarn = {
    isNormalUser = true;
    extraGroups = ["wheel"];
  };

  # 1Password CLI on all devices
  programs._1password.enable = true;

  environment.systemPackages = with pkgs; [
    wget
    gcc
    zip
    unzip
    fd
    ripgrep
    nh

    yazi
    btop

    imagemagick
  ];
}
