{inputs, ...}: let
  username = "tomwrw";
in {
  flake.modules.nixos."${username}" = {pkgs, ...}: {
    imports = with inputs.self.modules.nixos; [
      home-manager
    ];

    home-manager.users."${username}" = {
      imports = [
        inputs.self.modules.homeManager."${username}"
      ];
    };

    users.users."${username}" = {
      isNormalUser = true;
      initialPassword = "changeme";
      shell = pkgs.fish;
      extraGroups = [
        "wheel"
      ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFCIJ1LhkFDBZaZU/bf8Y3XyCXb3RnVxg4gRs6i+XbSe tomwrw@proton.me"
      ];
    };
    programs.fish.enable = true;
  };
}
