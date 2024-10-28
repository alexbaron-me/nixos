{pkgs, ...}: let
  cursor = pkgs.catppuccin-cursors.macchiatoSky;
in {
  programs.hyprland.enable = true;

  environment.systemPackages = [
    cursor
    pkgs.dunst
  ];

  security.pam.services.hyprlock = {};
  home-manager.users.albarn = let
    wallpaper = ./wallpapers/shaded_landscape.png;
  in {
    gtk.cursorTheme = {
      package = cursor;
    };
    home.pointerCursor = {
      package = cursor;
      name = "catppuccin-macchiato-sky-cursors";
      x11.enable = true;
    };

    services.dunst = {
      enable = true;
    };

    programs.hyprlock = {
      enable = true;
      settings = {
        source = ["~/.config/hypr/macchiato.conf"];
        general = {
          disable_loading_bar = true;
          grace = 0;
          hide_cursor = true;
          no_fade_in = false;
        };
        background = [
          {
            path = "${wallpaper}";
            blur_passes = 3;
            blur_size = 8;
          }
        ];
        input-field = [
          {
            size = "400, 50";
            position = "0, 0";
            monitor = "eDP-1";
            dots_center = true;
            fade_on_empty = false;
            outline_thickness = 2;
            shadow_passes = 2;
            font_color = "$text";
            inner_color = "$mantle";
            outer_color = "$mantle";
          }
        ];
      };
    };

    # services.hypridle = {
    #   enable = true;
    #   settings = {
    #     general = {
    #       after_sleep_cmd = "hyprctl dispatch dpms on";
    #       before_sleep_cmd = "loginctl lock-session";
    #       lock_cmd = "pidof ${pkgs.hyprlock}/bin/hyprlock || ${pkgs.hyprlock}/bin/hyprlock";
    #     };
    #
    #     listener = [
    #       {
    #         timeout = 150;
    #         on-timeout = "brightnessctl -s set 10";
    #         on-resume = "brightnessctl -r";
    #       }
    #       {
    #         timeout = 150;
    #         on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0";
    #         on-resume = "brightnessctl -rd rgb:kbd_backlight";
    #       }
    #     ];
    #   };
    # };

    services.hyprpaper = {
      enable = true;
      settings = {
        ipc = "on";
        splash = false;
        preload = ["${wallpaper}"];
        wallpaper = [
          "eDP-1,${wallpaper}"
        ];
      };
    };

    wayland.windowManager.hyprland = let
      terminal = "${pkgs.kitty}/bin/kitty";
      file_manager = "${pkgs.nautilus}/bin/nautilus";
      menu = "${pkgs.wofi}/bin/wofi --show drun";
    in {
      enable = true;
      settings = {
        monitor = [
          "eDP-1, 1920x1080, 0x0, 1"
          ",preferred,auto,auto"
        ];

        env = [
          "HYPRCURSOR_THEME,catppuccin-macchiato-sky-cursors"
          "XCURSOR_SIZE,24"
          "HYPRCURSOR_SIZE,24"
        ];

        exec = ["${pkgs.hyprpaper}/bin/hyprpaper &"];

        general = {
          gaps_in = 5;
          gaps_out = 10;

          border_size = 2;

          resize_on_border = true;

          layout = "master";

          "col.active_border" = "0xffa6da95";
          "col.inactive_border" = "0xff24273a";
        };

        decoration = {
          rounding = 8;

          active_opacity = 1;
          inactive_opacity = 1;

          drop_shadow = true;
          shadow_range = 4;
          shadow_render_power = 3;

          blur = {
            enabled = true;
            size = 3;
            passes = 1;
            vibrancy = 0.1696;
          };
        };

        animations = {
          enabled = true;
          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
          animation = [
            "windows, 1, 2, myBezier"
            "windowsOut, 1, 2, default, popin 80%"
            "border, 1, 3, default"
            "borderangle, 1, 2, default"
            "fade, 1, 2, default"
            "workspaces, 1, 1, default"
          ];
        };

        master.new_status = "inherit";

        misc.disable_hyprland_logo = true;

        input = {
          kb_layout = "eu";
          kb_options = "caps:swapescape";
          follow_mouse = 1;
          touchpad.natural_scroll = true;
        };

        gestures.workspace_swipe = true;

        "$mainMod" = "SUPER";

        bind = [
          # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
          "$mainMod, Return, exec, ${terminal}"
          "$mainMod, C, killactive,"
          "$mainMod, M, exit,"
          "$mainMod, E, exec, ${file_manager}"
          "$mainMod, V, togglefloating,"
          "$mainMod, R, exec, ${menu}"
          "$mainMod, P, pseudo,"
          "$mainMod, J, togglesplit,"
          "$mainMod, F, fullscreen"

          # Move focus with mainMod + [hjkl]
          "$mainMod, h, movefocus, l"
          "$mainMod, l, movefocus, r"
          "$mainMod, k, movefocus, u"
          "$mainMod, j, movefocus, d"

          # Move window with mainMod + shift + [hjkl]
          "$mainMod SHIFT, h, movewindow, l"
          "$mainMod SHIFT, l, movewindow, r"
          "$mainMod SHIFT, k, movewindow, u"
          "$mainMod SHIFT, j, movewindow, d"

          # Switch workspaces with mainMod + [0-9]
          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"
          "$mainMod, 0, workspace, 10"

          # Move active window to a workspace with mainMod + SHIFT + [0-9]
          "$mainMod SHIFT, 1, movetoworkspace, 1"
          "$mainMod SHIFT, 2, movetoworkspace, 2"
          "$mainMod SHIFT, 3, movetoworkspace, 3"
          "$mainMod SHIFT, 4, movetoworkspace, 4"
          "$mainMod SHIFT, 5, movetoworkspace, 5"
          "$mainMod SHIFT, 6, movetoworkspace, 6"
          "$mainMod SHIFT, 7, movetoworkspace, 7"
          "$mainMod SHIFT, 8, movetoworkspace, 8"
          "$mainMod SHIFT, 9, movetoworkspace, 9"
          "$mainMod SHIFT, 0, movetoworkspace, 10"

          # Example special workspace (scratchpad)
          "$mainMod, S, togglespecialworkspace, magic"
          "$mainMod SHIFT, S, movetoworkspace, special:magic"

          # Scroll through existing workspaces with mainMod + scroll
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"
        ];

        bindm = [
          # Move/resize with mainMod + LMB/RMB and dragging
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];

        # Media control
        bindl = [
          ", XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl next"
          ", XF86AudioPause, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
          ", XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
          ", XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl previous"
        ];

        # Multimedia keys: volume, brightness
        bindel = [
          ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
          ",XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl s 10%+"
          ",XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl s 10%-"
        ];

        windowrulev2 = [
          "suppressevent maximize, class:.*"
          "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
          "float,class:^float(ing)?$,"
        ];
      };
    };

    # From https://github.com/catppuccin/hyprland
    xdg.configFile."hypr/macchiato.conf".text = ''
      $rosewater = rgb(f4dbd6)
      $rosewaterAlpha = f4dbd6

      $flamingo = rgb(f0c6c6)
      $flamingoAlpha = f0c6c6

      $pink = rgb(f5bde6)
      $pinkAlpha = f5bde6

      $mauve = rgb(c6a0f6)
      $mauveAlpha = c6a0f6

      $red = rgb(ed8796)
      $redAlpha = ed8796

      $maroon = rgb(ee99a0)
      $maroonAlpha = ee99a0

      $peach = rgb(f5a97f)
      $peachAlpha = f5a97f

      $yellow = rgb(eed49f)
      $yellowAlpha = eed49f

      $green = rgb(a6da95)
      $greenAlpha = a6da95

      $teal = rgb(8bd5ca)
      $tealAlpha = 8bd5ca

      $sky = rgb(91d7e3)
      $skyAlpha = 91d7e3

      $sapphire = rgb(7dc4e4)
      $sapphireAlpha = 7dc4e4

      $blue = rgb(8aadf4)
      $blueAlpha = 8aadf4

      $lavender = rgb(b7bdf8)
      $lavenderAlpha = b7bdf8

      $text = rgb(cad3f5)
      $textAlpha = cad3f5

      $subtext1 = rgb(b8c0e0)
      $subtext1Alpha = b8c0e0

      $subtext0 = rgb(a5adcb)
      $subtext0Alpha = a5adcb

      $overlay2 = rgb(939ab7)
      $overlay2Alpha = 939ab7

      $overlay1 = rgb(8087a2)
      $overlay1Alpha = 8087a2

      $overlay0 = rgb(6e738d)
      $overlay0Alpha = 6e738d

      $surface2 = rgb(5b6078)
      $surface2Alpha = 5b6078

      $surface1 = rgb(494d64)
      $surface1Alpha = 494d64

      $surface0 = rgb(363a4f)
      $surface0Alpha = 363a4f

      $base = rgb(24273a)
      $baseAlpha = 24273a

      $mantle = rgb(1e2030)
      $mantleAlpha = 1e2030

      $crust = rgb(181926)
      $crustAlpha = 181926
    '';
  };
}
