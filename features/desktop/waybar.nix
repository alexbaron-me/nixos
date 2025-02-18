{pkgs, outputs, ...}: {
  home-manager.users.albarn.programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings.mainBar = {
      layer = "top";
      position = "top";
      modules-left = ["hyprland/workspaces" "privacy"];
      modules-center = ["custom/music"];
      modules-right = ["privacy" "pulseaudio" "backlight" "battery" "clock" "network" "custom/tailscale" "tray" "custom/lock" "custom/power"];
      "hyprland/workspaces" = {
        disable-scroll = true;
        format = " {icon} ";
        format-icons = {
          default = "";
          active = "";
        };
      };
      tray = {
        icon-size = 21;
        spacing = 10;
      };
      privacy = {
        icon-spacing = 4;
        icon-size = 18;
        transition-duration = 250;
        modules = [
          {
            type = "screenshare";
            tooltip = true;
            tooltip-icon-size = 2;
          }
          {
            type = "audio-out";
            tooltip = true;
            tooltip-icon-size = 2;
          }
          {
            type = "audio-in";
            tooltip = true;
            tooltip-icon-size = 2;
          }
        ];
      };
      network = {
        interface = "wlp0s20f3";
        format-wifi = "󰖩";
        format-disconnected = " 󰖪 ";
        tooltip-format-wifi = "{essid} ({signalStrength}%) 󰖩";
        tooltip-format-disconnected = "Disconnected";
        on-click = "${pkgs.kitty}/bin/kitty --class='floating' nmtui";
      };
      "custom/music" = {
        format = "  {}";
        escape = true;
        interval = 5;
        tooltip = false;
        exec = "${pkgs.playerctl}/bin/playerctl metadata --format='{{ title }} - {{ artist }}'";
        on-click = "${pkgs.playerctl}/bin/playerctl play-pause";
        max-length = 50;
      };
      "custom/tailscale" = {
        format = "{icon}";
        format-icons = {
          active = "󰒘";
          active-exitnode = "󰴳";
          inactive = "󰦞";
        };
        escape = true;
        interval = 5;
        exec = "${outputs.packages.${pkgs.system}.tailscale_status}/bin/tailscale_status";
        return-type = "json";
      };
      clock = {
        timezone = "Europe/Berlin";
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        format-alt = " {:%d/%m/%Y}";
        format = "󰥔 {:%H:%M}";
      };
      backlight = {
        device = "intel_backlight";
        format = "{icon}";
        format-icons = ["" "" "" "" "" "" "" "" ""];
      };
      battery = {
        states = {
          warning = 30;
          critical = 15;
        };
        format = "{icon} {capacity}%";
        format-charging = "󰂄 {capacity}%";
        format-plugged = "";
        format-icons = [
          "󰁺"
          "󰁻"
          "󰁻"
          "󰁽"
          "󰁾"
          "󰁿"
          "󰂀"
          "󰂁"
          "󰂂"
          "󰁹"
        ];
      };
      pulseaudio = {
        format = "{icon} {volume}%";
        format-muted = "  {volume}%";
        format-icons = {
          default = ["" " " " "];
        };
        on-click = "${pkgs.pwvucontrol}/bin/pwvucontrol";
      };
      "custom/lock" = {
        tooltip = false;
        on-click = "${pkgs.hyprlock}/bin/hyprlock";
        format = "";
      };
      "custom/power" = {
        tooltip = false;
        on-click = "wlogout &";
        format = "⏻";
      };
    };
    style = ''
      /* From https://github.com/rubyowo/dotfiles/blob/f925cf8e3461420a21b6dc8b8ad1190107b0cc56/config/waybar/macchiato.css */
      @define-color rosewater #f4dbd6;
      @define-color flamingo #f0c6c6;
      @define-color pink #f5bde6;
      @define-color mauve #c6a0f6;
      @define-color red #ed8796;
      @define-color maroon #ee99a0;
      @define-color peach #f5a97f;
      @define-color yellow #eed49f;
      @define-color green #a6da95;
      @define-color teal #8bd5ca;
      @define-color sky #91d7e3;
      @define-color sapphire #7dc4e4;
      @define-color blue #8aadf4;
      @define-color lavender #b7bdf8;
      @define-color text #cad3f5;
      @define-color subtext1 #b8c0e0;
      @define-color subtext0 #a5adcb;
      @define-color overlay2 #939ab7;
      @define-color overlay1 #8087a2;
      @define-color overlay0 #6e738d;
      @define-color surface2 #5b6078;
      @define-color surface1 #494d64;
      @define-color surface0 #363a4f;
      @define-color base #24273a;
      @define-color mantle #1e2030;
      @define-color crust #181926;

      * {
        font-family: CaskaydiaCove Nerd Font;
        font-size: 17px;
        min-height: 0;
      }

      #waybar {
        background: transparent;
        color: @text;
        margin: 5px 5px;
      }

      #workspaces {
        border-radius: 1rem;
        margin: 5px;
        background-color: @surface0;
        margin-left: 1rem;
      }

      #workspaces button {
        color: @lavender;
        border-radius: 1rem;
        padding: 0.4rem;
      }

      #workspaces button.active {
        color: @sky;
        border-radius: 1rem;
      }

      #workspaces button:hover {
        color: @sapphire;
        border-radius: 1rem;
      }

      #privacy {
        background-color: @peach;
        color: @white;
        border-radius: 1rem;
        margin: 5px 0;
        margin-left: 1rem;
        padding: 0.5rem 1rem;
      }

      #custom-music,
      #custom-tailscale,
      #tray,
      #backlight,
      #clock,
      #battery,
      #network,
      #pulseaudio,
      #custom-lock,
      #custom-power {
        background-color: @surface0;
        padding: 0.5rem 1rem;
        margin: 5px 0;
      }

      #clock {
        color: @blue;
      }

      #network {
        color: @green;
      }

      #custom-tailscale {
        border-radius: 0px 1rem 1rem 0px;
        padding-right: 1.5rem;
        margin-right: 1rem;
      }

      #battery {
        color: @green;
      }

      #battery.charging {
        color: @green;
      }

      #battery.warning:not(.charging) {
        color: @red;
      }

      #backlight {
        color: @yellow;
      }

      #backlight, #battery {
          border-radius: 0;
      }

      #pulseaudio {
        color: @maroon;
        border-radius: 1rem 0px 0px 1rem;
        margin-left: 1rem;
      }

      #custom-music {
        color: @mauve;
        border-radius: 1rem;
      }

      #custom-lock {
          border-radius: 1rem 0px 0px 1rem;
          color: @lavender;
      }

      #custom-power {
          margin-right: 1rem;
          border-radius: 0px 1rem 1rem 0px;
          color: @red;
      }

      #tray {
        margin-right: 1rem;
        border-radius: 1rem;
      }
    '';
  };
}
