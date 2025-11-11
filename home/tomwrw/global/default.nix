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

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      extra-substituters = [
        "https://chaotic-nyx.cachix.org/"
        "https://cosmic.cachix.org/"
        "https://niri.cachix.org/"
      ];
      extra-trusted-public-keys = [
        "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
        "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
        "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
      ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      warn-dirty = false;
    };
  };

  # Allow unfree packages (such as Steam).
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
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
