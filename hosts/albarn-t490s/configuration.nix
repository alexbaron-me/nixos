{...}: {
  networking.hostName = "albarn-t490s";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
