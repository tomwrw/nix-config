{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.niri.settings.window-rules = [
    {
      # Clips the window to its visual geometry.
      clip-to-geometry = true;
      # Override whether the border and the focus ring
      # draw with a background.
      draw-border-with-background = false;
      # Set the radius of window borders.
      geometry-corner-radius = {
        bottom-left = 0.0;
        bottom-right = 0.0;
        top-left = 0.0;
        top-right = 0.0;
      };
    }
    {
      # For active windows, make them less transparent.
      matches = [{is-active = true;}];
      opacity = 0.99;
    }
    {
      # For inactive windows, make them more transparent.
      matches = [{is-active = false;}];
      opacity = 0.95;
    }
    {
      matches = [
        {app-id = "zen";}
        {app-id = "firefox";}
        {app-id = "chromium-browser";}
        {app-id = "edge";}
      ];
      open-maximized = true;
      open-on-workspace = "web";
    }
    {
      matches = [
        {app-id = "codium";}
      ];
      open-maximized = true;
      open-on-workspace = "code";
    }
    {
      matches = [
        {app-id = "element";}
        {app-id = "signal";}
        {app-id = "whatsapp";}
      ];
      open-maximized = true;
      open-on-workspace = "chat";
    }
  ];
}
