{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  options.theme = {
    borderRadius = lib.mkOption {
      type = lib.types.float;
      default = 4.0;
      example = 1.0;
      description = ''
        Specify the preferred radius of borders
        to use in supported applications.
      '';
    };
    borderWidth = lib.mkOption {
      type = lib.types.float;
      default = 2.0;
      example = 1.0;
      description = ''
        Specify the preferred width of borders
        to use in supported applications.
      '';
    };
    opacity = lib.mkOption {
      type = lib.types.float;
      default = 1.0;
      example = 0.5;
      description = ''
        Specify the preferred opacity to use in
        supported applications.
      '';
    };
    borderGradient = lib.mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = ''
        Specify whether the theme should consider
        the use of a border gradient. This is
        useful for Window Managers such as niri
        or hyprland.
      '';
    };
    borderGradientAngle = lib.mkOption {
      type = lib.types.int;
      default = 45;
      example = 45;
      description = ''
        Specify the angle of the border gradient
        in degrees.
      '';
    };
    borderShadow = lib.mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = ''
        Specify whether to use a border shadow.
      '';
    };
    spacing = lib.mkOption {
      type = lib.types.submodule {
        options = {
          xs = lib.mkOption {
            type = lib.types.int;
            default = 4;
          };
          s = lib.mkOption {
            type = lib.types.int;
            default = 8;
          };
          m = lib.mkOption {
            type = lib.types.int;
            default = 12;
          };
          l = lib.mkOption {
            type = lib.types.int;
            default = 16;
          };
          xl = lib.mkOption {
            type = lib.types.int;
            default = 20;
          };
        };
      };
      default = {};
    };
  };
}
