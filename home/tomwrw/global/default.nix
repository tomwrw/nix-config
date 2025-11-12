{
  inputs,
  lib,
  pkgs,
  config,
  outputs,
  ...
}: {
  imports =
    [
      # Import the Home Manager impermanence module in case
      # we have it declared for our system.
      inputs.impermanence.homeManagerModules.impermanence
      # Import stylix as this is used throughout this
      # configuration to theme applications.
      inputs.stylix.homeModules.stylix
      # Import all global features for this user on this
      # host. I could use a default file in required folders
      # but I found it better to be specific and import
      # one by one.
      ../features/cli/alacritty.nix
      ../features/cli/btop.nix
      ../features/cli/git.nix
      ../features/cli/neovim.nix
      ../features/cli/zsh.nix
    ]
    # Include any custom Home Manager modules I have defined.
    ++ (builtins.attrValues outputs.homeManagerModules);

  # Nix configuration (nix.*) is managed at the system level in hosts/common/core/nix.nix
  # Home Manager inherits these settings from NixOS, so no duplication needed here.

  # Note: nixpkgs.config needs to be set in Home Manager even when used as a NixOS module
  # because Home Manager evaluates packages separately. The system-level setting doesn't
  # automatically propagate to Home Manager's package evaluation.
  nixpkgs.config.allowUnfree = true;

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
    stateVersion = lib.mkDefault "25.05";
    sessionPath = ["$HOME/.local/bin"];
    sessionVariables = {
      NH_FLAKE = "$HOME/Development/nix-config";
    };
  };

  # Include some packages by default. I typically
  # include anything I need to work with nix.
  home.packages = with pkgs; [
    comma # Install and run programs by sticking a , before them
    distrobox # Nice escape hatch, integrates docker images with my environment
    bc # Calculator
    bottom # System viewer
    ncdu # TUI disk usage
    eza # Better ls
    ripgrep # Better grep
    fastfetch # System overview
    fd # Better find
    httpie # Better curl
    jq # JSON pretty printer and manipulator
    timer # To help with my ADHD paralysis
    viddy # Better watch
    nixd # Nix LSP
    alejandra # Nix formatter
    nixfmt-rfc-style
    nvd # Differ
    nix-diff # Differ, more detailed
    nix-output-monitor
    nh # Nice wrapper for NixOS and HM
  ];

  # Turn on stylix for themes.
  stylix = {
    enable = true;
    autoEnable = true;
  };

  # Global persists for anything that could be global
  # or optional for nixos configs, like Steam.
  home.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "Development"
      "Documents"
      "Downloads"
      "Music"
      "Pictures"
      "Videos"
      ".openvpn"
      ".password-store"
      ".themes"
      ".config/sunshine"
      ".config/dconf"
      ".config/openrazer"
      ".config/polychromatic"
      ".local/share/nix"
      ".local/state"
      ".local/share/Steam"
      ".local/share/direnv"
      ".local/share/PrismLauncher"
      ".steam"
      ".cache/virt-manager"
      {
        directory = ".ssh";
        mode = "0700";
      }
      {
        directory = ".pki";
        mode = "0700";
      }
      {
        directory = ".gnupg";
        mode = "0700";
      }
      {
        # Keyrings store passwords and other secrets for applications.
        # Persisting this is important for not having to log in repeatedly.
        directory = ".local/share/keyrings";
        mode = "0700";
      }
    ];
    files = [
      #".face"
      ".screenrc"
    ];
  };
}
