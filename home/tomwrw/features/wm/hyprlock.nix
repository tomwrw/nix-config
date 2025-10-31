{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  programs.hyprlock = {
    enable = true;
    settings = {
      auth = {
        fingerprint.enabled = false;
      };
      background = {
        monitor = "";
        blur_passes = 3;
      };
      input-field = {
        monitor = "";
        size = "600, 100";
        position = "0, 0";
        halign = "center";
        valign = "center";
        outline_thickness = 4;
        placeholder_text = " Authenticate   󰈷 ";
        fail_text = "Wrong";

        rounding = 0;
        shadow_passes = 0;
        fade_on_empty = false;
      };

      label = {
        monitor = "";
        text = "\$FPRINTPROMPT";
        text_align = "center";
        position = "0, -100";
        halign = "center";
        valign = "center";
      };
    };
  };
}
