{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./hyprland.nix
    ./nvim
    ./waybar.nix
    ./firefox.nix
    ./sddm.nix
    # ./disko-config.nix
  ];

  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = ["CascadiaCode"];})
  ];

  environment.sessionVariables = {
    FLAKE = "path:///home/albarn/.nixos";
    NIXPKGS_ALLOW_UNFREE = "1";
  };

  catppuccin.flavor = "macchiato";
  catppuccin.enable = true;
  home-manager.users.albarn.catppuccin.enable = true;

  nixpkgs.config.allowUnfree = true;

  

  # Also requires gnome-keyring
  services.gnome.gnome-keyring.enable = true;
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    # Certain features, including CLI integration and system authentication support,
    # require enabling PolKit integration on some desktop environments (e.g. Plasma).
    polkitPolicyOwners = ["albarn"];
  };

  home-manager.users.albarn.programs.lazygit.enable = true;
  home-manager.users.albarn.programs.git = {
    enable = true;
    userEmail = "alexander.baron1@rwth-aachen.de";
    userName = "Alexander Baron";
  };

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
  environment.pathsToLink = ["/share/zsh"];
  home-manager.users.albarn.programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
  home-manager.users.albarn.programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      inline_height = 50;
      enter_accept = true;
      filter_mode_shell_up_key_binding = "directory";
    };
  };
  home-manager.users.albarn.programs = {
    bat.enable = true;
    eza.enable = true;
    firefox.enable = true;

    fzf = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      fileWidgetOptions = ["--preview '${pkgs.bat}/bin/bat {}'"];
      tmux.enableShellIntegration = true;
    };
  };
  home-manager.users.albarn.services.dunst = {
    enable = true;
  };

  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
  };

  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      adblock
      hidePodcasts
      shuffle # shuffle+ (special characters are sanitized out of extension names)
    ];
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "macchiato";
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "albarn-t490s";

  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.albarn = {
    isNormalUser = true;
    extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
    packages = with pkgs; [
      firefox
      thunderbird
      dolphin
      wofi
      inputs.zen-browser.packages."${system}".specific
    ];
  };

  programs.zsh.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    wget
    kitty
    gcc
    git
    lazygit
    tmux
    fd
    nh

    dunst
    libnotify

    yazi
    btop

    imagemagick
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?
  home-manager.users.albarn.home.stateVersion = "23.11";
}
