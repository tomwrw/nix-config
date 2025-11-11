{
  config,
  pkgs,
  ...
}: {
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 22;
        spacing = 0;

        modules-left = ["niri/workspaces" "niri/window"];
        modules-center = [];
        modules-right = ["pulseaudio" "network" "cpu" "memory" "clock" "tray"];

        "niri/workspaces" = {
          format = "{index}{windows}";
          format-window-separator = " ";
          window-rewrite-default = "□";
          window-rewrite = {
            ".*" = "■";
          };
        };

        "niri/window" = {
          format = "{title}";
          max-length = 50;
          rewrite = {
            "(.*) — Mozilla Firefox" = "🌎 $1";
            "(.*) - vim" = " $1";
          };
        };

        clock = {
          format = "{:%a %b %d %H:%M}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        cpu = {
          format = "CPU {usage}%";
          tooltip = false;
        };

        memory = {
          format = "MEM {}%";
        };

        network = {
          format-wifi = "WiFi {essid}";
          format-ethernet = "ETH {ifname}";
          format-disconnected = "Disconnected";
          tooltip-format = "{ipaddr}/{cidr}";
        };

        pulseaudio = {
          format = "VOL {volume}%";
          format-muted = "VOL MUTE";
          on-click = "pavucontrol";
        };

        tray = {
          spacing = 10;
        };
      };
    };

    style = ''
      * {
        font-family: "monospace";
        font-size: 13px;
        font-weight: bold;
        border: none;
        border-radius: 0;
        min-height: 0;
      }

      window#waybar {
        background-color: #222222;
        color: #bbbbbb;
        border-bottom: 1px solid #444444;
      }

      /* Workspace styling - DWM style */
      #workspaces {
        background-color: #005577;
        padding: 0;
        margin: 0;
      }

      #workspaces button {
        padding: 0 8px;
        background-color: #005577;
        color: #eeeeee;
        border-right: 1px solid #444444;
      }

      #workspaces button:hover {
        background-color: #006688;
      }

      #workspaces button.active {
        background-color: #222222;
        color: #eeeeee;
      }

      #workspaces button.urgent {
        background-color: #ff0000;
        color: #ffffff;
      }

      /* Window title */
      #window {
        padding: 0 10px;
        background-color: #222222;
        color: #bbbbbb;
      }

      /* Status modules */
      #clock,
      #cpu,
      #memory,
      #network,
      #pulseaudio {
        padding: 0 10px;
        background-color: #222222;
        color: #bbbbbb;
        border-left: 1px solid #444444;
      }

      #tray {
        padding: 0 5px;
        background-color: #222222;
      }

      #tray > .passive {
        -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
      }
    '';
  };
}
