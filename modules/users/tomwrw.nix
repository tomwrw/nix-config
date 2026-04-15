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
      vscodium
    ];

    home.username = "tomwrw";
    home.homeDirectory = "/home/tomwrw";
    home.stateVersion = "25.11";

    home.packages = with pkgs; [
      fastfetch
      ripgrep
    ];
  };
}
