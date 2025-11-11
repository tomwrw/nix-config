{
  config,
  pkgs,
  ...
}: {
  programs.niri.settings.binds = with config.lib.niri.actions; {
    # Common keybinds.
    "Mod+Return".action = spawn "${pkgs.alacritty}/bin/alacritty";
    "Mod+E".action = spawn "${pkgs.nemo}/bin/nemo";
    "Mod+Q".action = close-window;
    "Mod+F".action = maximize-column;
    "Mod+Space".action = spawn-sh ["pkill wofi || wofi -n --show drun"];
    "Mod+Escape".action = spawn-sh ["pkill wofi || wofi-power-menu"];

    # Groups/tabs.
    "Mod+G".action = toggle-column-tabbed-display;
    "Mod+I".action = consume-window-into-column;
    "Mod+O".action = expel-window-from-column;

    # "Mod+Q".action = close-window;
    # "Mod+S".action = switch-preset-column-width;
    # "Mod+F".action = maximize-column;
    # "Mod+V".action = spawn-sh ["pkill wofi || cliphist list | wofi -n -d -p Clipboard | cliphist decode | wl-copy"];
    # "Mod+L".action = spawn ["hyprlock"];

    # "Print".action.screenshot = [];
    # "Print".hotkey-overlay.title = "Screenshot via Niri";
    # "Mod+Print".action = spawn "satty-screenshot";
    # "Mod+Print".hotkey-overlay.title = "Screenshot via Satty";
    # "Mod+Shift+Print".action = spawn "satty-screenshot-region";
    # "Mod+Shift+Print".hotkey-overlay.title = "Screeshot Region via Satty";

    "Mod+1".action.focus-workspace = [1];
    "Mod+2".action.focus-workspace = [2];
    "Mod+3".action.focus-workspace = [3];
    "Mod+4".action.focus-workspace = [4];
    "Mod+5".action.focus-workspace = [5];
    "Mod+Shift+1".action.move-column-to-workspace = [1];
    "Mod+Shift+2".action.move-column-to-workspace = [2];
    "Mod+Shift+3".action.move-column-to-workspace = [3];
    "Mod+Shift+4".action.move-column-to-workspace = [4];
    "Mod+Shift+5".action.move-column-to-workspace = [5];

    # "Mod+1".action = set-column-width "25%";
    # "Mod+2".action = set-column-width "50%";
    # "Mod+3".action = set-column-width "75%";
    # "Mod+4".action = set-column-width "100%";

    # "Mod+Shift+F".action = expand-column-to-available-width;
    # "Mod+G".action = toggle-window-floating;
    # "Mod+W".action = toggle-column-tabbed-display;

    # "Mod+Comma".action = consume-window-into-column;
    # "Mod+Period".action = expel-window-from-column;
    # "Mod+C".action = center-visible-columns;
    # "Mod+Tab".action = switch-focus-between-floating-and-tiling;

    "Mod+Minus".action = set-column-width "-10%";
    "Mod+Plus".action = set-column-width "+10%";
    "Mod+Shift+Minus".action = set-window-height "-10%";
    "Mod+Shift+Plus".action = set-window-height "+10%";

    "Mod+Left".action = focus-column-left;
    "Mod+Right".action = focus-column-right;
    "Mod+Down".action = focus-workspace-down;
    "Mod+Up".action = focus-workspace-up;

    "Mod+Shift+Left".action = move-column-left;
    "Mod+Shift+Right".action = move-column-right;
    "Mod+Shift+Up".action = move-column-to-workspace-up;
    "Mod+Shift+Down".action = move-column-to-workspace-down;

    # "Mod+Shift+Ctrl+J".action = move-column-to-monitor-down;
    # "Mod+Shift+Ctrl+K".action = move-column-to-monitor-up;
  };
}
