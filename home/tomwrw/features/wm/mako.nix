{
  config,
  pkgs,
  ...
}: let
  colors = config.lib.stylix.colors;
  colorBackground = colors.base00;
  colorText = colors.base05;
  colorBorder = colors.base04;
  colorProgress = colors.base0D;
in {
  services.mako = {
    enable = true;
    settings = {
      background-color = "#${colorBackground}";
      text-color = "#${colorText}";
      border-color = "#${colorBorder}";
      progress-color = "#${colorProgress}";
      width = 420;
      height = 110;
      padding = "10";
      margin = "10";
      border-size = 4;
      border-radius = 0;
      anchor = "top-right";
      layer = "overlay";
      default-timeout = 5000;
      ignore-timeout = false;
      max-visible = 5;
      sort = "-time";
      group-by = "app-name";
      actions = true;
      format = "<b>%s</b>\\n%b";
      markup = true;
    };
  };
}
