{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;

    settings = {
      main = with config.lib.stylix.colors.withHashtag; {
        reload_style_on_change = true;
        layer = "top";
        position = "top";
        spacing = 0;
        height = 28;

        modules-left = [
          "niri/workspaces"
          "niri/window"
        ];

        modules-center = [
          "clock"
        ];

        modules-right = [
          "network"
          "bluetooth"
          "pulseaudio"
          "disk"
          "cpu"
          "memory"
        ];

        "niri/workspaces" = {
          on-click = "activate";
          format = "{icon}";
          format-icons = {
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
          };
        };

        "niri/window" = {
          format = "{}";
          max-length = 50;
        };

        clock = {
          interval = 60;
          format = "{:%d-%m-%Y %H:%M}";
        };

        cpu = {
          interval = 3;
          format = "CPU {usage:03}%";
        };

        memory = {
          interval = 3;
          format = "MEM {percentage:03}%";
        };

        disk = {
          interval = 30;
          format = "DSK {percentage_used:03}%";
          path = "/";
        };

        bluetooth = {
          format = "<s>BLU {num_connections:03}</s>";
          format-disabled = "<s>BLU 000</s>";
          format-on = "BLU {num_connections:03}";
          format-connected = "BLU {num_connections:03}";
          on-click = "blueberry";
          on-right-click = "bluetoothctl power toggle";
          tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
        };

        pulseaudio = {
          format = "VOL {volume:03}%";
          format-muted = "<s>VOL {volume:03}%</s>";
          on-click = "alacritty -e wiremix";
          on-click-right = "pamixer -t";
          tooltip-format = "Playing at {volume}%";
          scroll-step = 5;
        };

        network = {
          format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
          format = "{icon}";
          format-wifi = "{icon}";
          format-ethernet = "󰀂";
          format-disconnected = "󰤮";
          tooltip-format-wifi = "{essid} ({frequency} GHz)\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
          tooltip-format-ethernet = "⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
          tooltip-format-disconnected = "Disconnected";
          interval = 3;
          spacing = 1;
          on-click = "alacritty -e impala";
        };

        # network = {
        #   format-wifi = "SEN {bandwidthUpBits:>3} REC {bandwidthDownBits:>3}";
        #   format-ethernet = "SEN {bandwidthUpBits:>3} REC {bandwidthDownBits:>3}";
        #   format-disconnected = "<s>SEN {bandwidthUpBits:>3} REC {bandwidthDownBits:>3}</s>";
        #   tooltip-format = "{ipaddr}/{cidr} - {essid}";
        #   interval = 1;
        # };

        # network = {
        #   format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
        #   format = "{icon}";
        #   format-wifi = "{icon}";
        #   format-ethernet = "󰀂";
        #   format-disconnected = "󰤮";
        #   tooltip-format-wifi = "{essid} ({frequency} GHz)\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
        #   tooltip-format-ethernet = "⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
        #   tooltip-format-disconnected = "Disconnected";
        #   interval = 3;
        #   spacing = 1;
        #   on-click = "alacritty -e impala";
        # };
      };
    };
    style = with config.lib.stylix.colors.withHashtag; ''
      * {
        border: none;
        border-radius: 0;
        font-family: '${config.stylix.fonts.monospace.name}', monospace;
        font-size: 12px;
        min-height: 0;
      }

      window#waybar {
        background: ${base00};
        color: ${base05};
      }

      #workspaces {
        background: ${base01};
      }

      #workspaces button {
        padding: 0 4px;
      }

      #workspaces button.active {
        background: ${base0D};
        color: ${base00};
      }

      #workspaces button.visible {

      }

      #workspaces button.urgent {
        background: ${base08};
        color: ${base07};
      }

      #workspaces button.empty {
        background: ${base02};
        color: ${base05};
      }

      #workspaces button.persistent {

      }

      #workspaces button.hidden {

      }

      #window {
        margin-left: 10px;
      }

      #cpu,
      #memory,
      #disk,
      #bluetooth,
      #pulseaudio,
      #network {
        padding: 0 8px;
        background: ${base0D};
        color: ${base00};
      }
    '';
  };
}
