{
  lib,
  config,
  ...
}: {
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
    # Configure user settings for home-manager.
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
