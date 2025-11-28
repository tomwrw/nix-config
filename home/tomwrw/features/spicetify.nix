{
  pkgs,
  lib,
  inputs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {
  # Allow spotify to be installed as I don't have unfree enabled.
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "spotify"
    ];

  # Import the flake's module for my host.
  imports = [inputs.spicetify-nix.homeManagerModules.default];

  # Configure spicetify.
  programs.spicetify = {
    enable = true;

    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplay
      shuffle
    ];
  };
  # This app requires the following persisted directories
  # and folders. Be This will only apply if impermanence is
  # enabled, and as soon as a user and host become out of
  # scope for this module, the items here will no longer
  # be persisted (they'll still exist in /persist thought).
  home.persistence."/persist" = {
    directories = [
      # Persisted directories go here (if needed).
      ".config/spotify"
    ];
    files = [
      # Persisted files go here (if needed).
    ];
  };
}
