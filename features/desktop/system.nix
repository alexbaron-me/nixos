# Basic system stuff shared on all desktop hosts
{
  pkgs,
  inputs,
  ...
}: {
  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
  };

  services.printing.enable = true;

  environment.systemPackages = with pkgs; [
    libnotify
  ];

  users.users.albarn.packages = with pkgs; [
    inputs.zen-browser.packages."${pkgs.system}".specific
  ];
}
