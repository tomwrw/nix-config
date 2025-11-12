{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.niri = {
    enable = true;
    package = pkgs.niri;
    settings = {
      xwayland-satellite = {
        enable = true;
      };
      environment = {
        DISPLAY = ":0";
        NIXOS_OZONE_WL = "1";
        CLUTTER_BACKEND = "wayland";
        GDK_BACKEND = "wayland,x11";
        MOZ_ENABLE_WAYLAND = "1";
        QT_QPA_PLATFORM = "wayland;xcb";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        SDL_VIDEODRIVER = "wayland";
      };
      input = {
        keyboard.xkb.layout = "gb";
        touchpad = {
          click-method = "button-areas";
          dwt = true;
          dwtp = true;
          natural-scroll = true;
          scroll-method = "two-finger";
          tap = true;
          tap-button-map = "left-right-middle";
          middle-emulation = true;
          accel-profile = "adaptive";
        };
        focus-follows-mouse = {
          enable = true;
          max-scroll-amount = "90%";
        };
        warp-mouse-to-focus.enable = true;
        workspace-auto-back-and-forth = false;
      };

      overview = {
        workspace-shadow.enable = false;
        backdrop-color = "transparent";
      };
      gestures = {hot-corners.enable = true;};

      layout = {
        focus-ring.enable = false;
        border = {
          enable = true;
          width = 2.0;
          active.color = "#${config.lib.stylix.colors.base0D}";
          inactive.color = "#${config.lib.stylix.colors.base03}";
        };
        # border = with config.colorScheme.palette; {
        #   enable = true;
        #   active = {
        #     color = "#${colorBorderActive}";
        #   };
        #   inactive = {
        #     color = "#${colorBorderInactive}";
        #   };
        #   width = config.theme.borderWidth;
        # };
        # shadow = {
        #   enable = true;
        #   spread = 0.01;
        #   offset.x = 0;
        #   offset.y = 0;
        #   softness = 3.0;
        #   draw-behind-window = false;
        #   color = "#000000";
        # };
        preset-column-widths = [
          {proportion = 0.25;}
          {proportion = 0.5;}
          {proportion = 0.75;}
          {proportion = 1.0;}
        ];
        default-column-width = {proportion = 0.5;};

        gaps = 8;

        # struts = {
        #   left = 0;
        #   right = 0;
        #   top = 0;
        #   bottom = 0;
        # };

        tab-indicator = {
          hide-when-single-tab = true;
          place-within-column = true;
          position = "left";
          corner-radius = 20.0;
          gap = -12.0;
          gaps-between-tabs = 10.0;
          width = 4.0;
          length.total-proportion = 0.1;
        };
      };

      workspaces = {
        "01-web" = {
          name = "web";
        };
        "02-code" = {
          name = "code";
        };
        "03-virt" = {
          name = "virt";
        };
        "04-cli" = {
          name = "cli";
        };
        "05-chat" = {
          name = "chat";
        };
        "06-game" = {
          name = "game";
        };
      };

      animations = {
        enable = false;
        #   window-open = {
        #     kind.easing = {
        #       curve = "ease-out-expo";
        #       duration-ms = 100;
        #     };
        #   };
        #   window-close.kind.easing = {
        #     curve = "ease-out-quad";
        #     duration-ms = 100;
        #   };
      };

      # Hide client-side decorations.
      prefer-no-csd = true;
      # Skip the hotkey overview on launch.
      hotkey-overlay.skip-at-startup = true;
      # Default screenshot path.
      screenshot-path = "~/Pictures/Screenshots/Screenshot-%Y-%m-%d-%H-%M-%S.png";
    };
  };
}
