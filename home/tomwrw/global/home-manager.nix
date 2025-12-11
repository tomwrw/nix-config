{
  lib,
  config,
  ...
}: {
  # Note: nixpkgs.config needs to be set in Home Manager even when used as a NixOS module
  # because Home Manager evaluates packages separately. The system-level setting doesn't
  # automatically propagate to Home Manager's package evaluation.
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      # Add any insecure packages here.
    ];
  };
  # This setting ensures that user-level systemd services are started correctly
  # when using Home Manager with NixOS. It's a required boilerplate for
  # proper integration.
  systemd.user.startServices = "sd-switch";
  # Enable these programs for this user on all hosts.
  programs = {
    home-manager.enable = true;
    git.enable = true;
  };
  # Set up my Home Manager instance.
  home = {
    # TODO: Adjust username here accordingly.
    username = lib.mkDefault "tomwrw";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    sessionPath = ["$HOME/.local/bin"];
    sessionVariables = {
      NH_FLAKE = "$HOME/Development/nix-config";
      EDITOR = "nvim";
      BROWSER = "firefox";
      TERMINAL = "ghostty";
      NIXOS_OZONE_WL = "1";
    };
  };
}
