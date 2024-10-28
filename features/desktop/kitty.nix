{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    kitty
  ];

  home-manager.users.albarn.programs.kitty = {
    enable = true;
    settings = {
      background_blur = 1;
      background_opacity = 0.95;
    };
    keybindings = {
      "ctrl+c" = "copy_or_interrupt";
      "ctrl+f>1" = "set_font_size 11";
      "ctrl+f>2" = "set_font_size 20";
    };
  };
}
