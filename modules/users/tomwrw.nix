{inputs, ...}: {
  flake.modules.nixos.tomwrw = {
    pkgs,
    config,
    ...
  }: {
    imports = [inputs.self.modules.nixos.home-manager];

    sops.secrets."password-tomwrw" = {
      sopsFile = ../../secrets/shared.yaml;
      neededForUsers = true;
    };

    users.users.tomwrw = {
      isNormalUser = true;
      hashedPasswordFile = config.sops.secrets."password-tomwrw".path;
      shell = pkgs.fish;
      extraGroups = ["wheel"];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFCIJ1LhkFDBZaZU/bf8Y3XyCXb3RnVxg4gRs6i+XbSe tomwrw@proton.me"
      ];
    };
    programs.fish.enable = true;

    home-manager.users.tomwrw = {
      imports = [inputs.self.modules.homeManager.tomwrw];
    };
  };

  flake.modules.homeManager.tomwrw = {pkgs, ...}: {
    imports = with inputs.self.modules.homeManager; [
      element-desktop
      ente-desktop
      ente-auth
      filen-desktop
      fish
      firefox
      gaming
      ghostty
      gnome
      signal-desktop
      spotify
      stylix
      vscodium
    ];

    home.username = "tomwrw";
    home.homeDirectory = "/home/tomwrw";
    home.stateVersion = "25.11";

    # Fix to silence the evaluation warning.
    gtk.gtk4.theme = null;

    home.packages = with pkgs; [
      nh # NixOS configuration helper and cleaner.
      nix-diff # Tool to compare two Nix derivations.
      nix-output-monitor # Monitors and shows build logs for Nix.
      nixd # Nix language server.
      nixfmt # Nix code formatter conforming to RFC 0048.
      nvd # Nix vulnerability scanner.
    ];

    stylix = {
      enable = true;
      polarity = "dark";
      image = ../../assets/wallpaper/snake.png;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine-moon.yaml";
      overlays.enable = false;
      targets = {
        firefox = {
          profileNames = ["default"];
          firefoxGnomeTheme.enable = true;
        };
        qt.enable = false;
      };
    };
  };
}
