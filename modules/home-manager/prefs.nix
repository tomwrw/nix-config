{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  options.prefs = {
    terminal = lib.mkOption {
      # The argument to lib.types.submodule must be a function
      # that takes { config, lib, pkgs, ... } and returns the submodule definition.
      # The submodule's options must be nested under 'options'.
      type = lib.types.submodule (
        {
          config,
          lib,
          pkgs,
          ...
        }: {
          options = {
            package = lib.mkOption {
              type = lib.types.package;
              default = pkgs.alacritty;
              example = pkgs.kitty;
              description = ''
                The terminal package to use.
              '';
            };

            executable = lib.mkOption {
              type = lib.types.str;
              default = "alacritty";
              example = "kitty";
              description = ''
                The terminal executable name.
              '';
            };
          };
        }
      );

      # Provide a default value for the *entire* submodule, otherwise
      # Nix will complain that there's no definition for `prefs.terminal`.
      # We default the entire submodule to an empty set, letting the
      # individual sub-options' defaults take over.
      default = {};
      description = "Configuration for the preferred terminal emulator.";
    };
    fileManager = lib.mkOption {
      # The argument to lib.types.submodule must be a function
      # that takes { config, lib, pkgs, ... } and returns the submodule definition.
      # The submodule's options must be nested under 'options'.
      type = lib.types.submodule (
        {
          config,
          lib,
          pkgs,
          ...
        }: {
          options = {
            package = lib.mkOption {
              type = lib.types.package;
              default = pkgs.nemo;
              example = pkgs.nautilus;
              description = ''
                The file manager package to use.
              '';
            };

            executable = lib.mkOption {
              type = lib.types.str;
              default = "nemo";
              example = "nautilus";
              description = ''
                The file manager executable name.
              '';
            };
          };
        }
      );

      # Provide a default value for the *entire* submodule, otherwise
      # Nix will complain that there's no definition for `prefs.terminal`.
      # We default the entire submodule to an empty set, letting the
      # individual sub-options' defaults take over.
      default = {};
      description = "Configuration for the preferred file manager.";
    };
  };
}
