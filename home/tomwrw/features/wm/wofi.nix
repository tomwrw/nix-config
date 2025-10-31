{
  config,
  pkgs,
  ...
}: let
  colors = config.lib.stylix.colors;
  fonts = config.stylix.fonts;
  colorBackground = colors.base00;
  colorForeground = colors.base05;
  colorSelected = colors.base03;
  fontMono = fonts.monospace.name;
in {
  programs.wofi = {
    enable = true;
    settings = {
      width = 600;
      height = 350;
      location = "center";
      show = "drun";
      prompt = "Search...";
      filter_rate = 100;
      allow_markup = true;
      no_actions = true;
      halign = "fill";
      orientation = "vertical";
      content_halign = "fill";
      insensitive = true;
      allow_images = true;
      image_size = 40;
      gtk_dark = true;
    };
    style = ''
      @define-color background #${colorBackground};
      @define-color foreground #${colorForeground};
      @define-color selected #${colorSelected};

        * {
          font-family: '${fontMono}', monospace;
          font-size: 18px;
        }

        window {
          margin: 0px;
          padding: 20px;
          background-color: @background;
          opacity: 0.99;
          border: none;
        }

        #inner-box {
          margin: 0;
          padding: 0;
          border: none;
          background-color: @background;
        }

        #outer-box {
          margin: 0;
          padding: 20px;
          border: none;
          background-color: @background;
        }

        #scroll {
          margin: 0;
          padding: 0;
          border: none;
          background-color: @background;
        }

        #input {
          margin: 0;
          padding: 10px;
          border: none;
          background-color: @background;
          color: @foreground;
        }

        #input:focus {
          outline: none;
          box-shadow: none;
          border: none;
        }

        #text {
          margin: 5px;
          border: none;
          color: @foreground;
        }

        #entry {

        }

        #entry:nth-child(odd) {
          background-color: transparent;
        }

        #entry:nth-child(even) {
          background-color: transparent;
        }

        #entry:selected {
          outline: none;
          border: none;
          background-color: @selected;
        }

        #entry:selected #text {

        }

        #entry image {
          -gtk-icon-transform: scale(0.7);
        }
    '';
  };

  home.packages = with pkgs; [
    (
      writeShellScriptBin "wofi-power-menu"
      ''
        entries="Lock Reboot Shutdown Logout"
        selected=$(printf '%s\n' $entries |  wofi -n -i --dmenu --hide-search --hide-scroll --width 250 | awk '{print tolower($1)}')

        case $selected in
          lock)
            exec hyprlock;;
          reboot)
            exec systemctl reboot;;
          shutdown)
            exec systemctl poweroff -i;;
          logout)
            exec niri msg action quit -s;;
        esac
      ''
    )
  ];
}
