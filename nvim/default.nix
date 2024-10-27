{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    gh # Used by octo
    fzy # Used by telescope
  ];

  home-manager.users.albarn = {
    xdg.enable = true;
    xdg.configFile."nvim" = {
      recursive = true;
      source = ./nvim;
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
