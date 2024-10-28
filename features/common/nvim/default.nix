{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    neovim
    gh # Used by octo
    fzy # Used by telescope

    imagemagick # Used for image rendering
  ];

  home-manager.users.albarn = {
    xdg.enable = true;
    xdg.configFile."nvim" = {
      recursive = true;
      source = ./config;
    };

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      vimdiffAlias = true;
      extraLuaPackages = luaPkgs: with luaPkgs; [magick];
    };
  };
}
