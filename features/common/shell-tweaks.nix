{pkgs, ...}: {
  home-manager.users.albarn.programs = {
    starship = {
      enable = true;
      enableZshIntegration = true;
    };

    atuin = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        inline_height = 50;
        enter_accept = true;
        filter_mode_shell_up_key_binding = "directory";
      };
    };

    bat.enable = true;
    eza.enable = true;

    fzf = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      fileWidgetOptions = ["--preview '${pkgs.bat}/bin/bat {}'"];
      tmux.enableShellIntegration = true;
    };
  };
}
