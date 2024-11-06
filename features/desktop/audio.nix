{pkgs, ...}: {
  users.users.albarn.packages = with pkgs; [
    pwvucontrol
  ];
}
