{pkgs, ...}: {
  services.displayManager.sddm = {
    enable = true;
    autoNumlock = true;
    settings = {};
    wayland.enable = true;
    package = pkgs.kdePackages.sddm;
  };
}
