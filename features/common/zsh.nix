{pkgs, ...}: {
  home-manager.users.albarn.programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    defaultKeymap = "viins";
    loginExtra = "${pkgs.pfetch}/bin/pfetch";
    shellAliases = {
      "ls" = "${pkgs.eza}/bin/eza";
      "l" = "${pkgs.eza}/bin/eza -lah";
      "cat" = "${pkgs.bat}/bin/bat";
    };
    syntaxHighlighting.enable = true;
  };

  users.users.albarn.shell = pkgs.zsh;
  programs.zsh.enable = true;
  environment.pathsToLink = ["/share/zsh"];
}
