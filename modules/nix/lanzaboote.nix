{inputs, ...}: {
  flake-file.inputs.lanzaboote.url = "github:nix-community/lanzaboote";

  flake.modules.nixos.lanzaboote = {lib, ...}: {
    imports = [inputs.lanzaboote.nixosModules.lanzaboote];

    boot.loader.systemd-boot.enable = lib.mkForce false;
    boot.lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
      autoGenerateKeys.enable = true;
      autoEnrollKeys = {
        enable = true;
        autoReboot = true;
      };
    };

    environment.persistence."/persist" = {
      directories = ["/var/lib/sbctl"];
    };
  };
}
