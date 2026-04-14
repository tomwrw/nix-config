{inputs, ...}: {
  flake-file.inputs = {
    impermanence.url = "github:nix-community/impermanence";
  };

  flake.modules.nixos.impermanence = {
    imports = [
      inputs.impermanence.nixosModules.impermanence
    ];

    environment.persistence."/persist" = {
      hideMounts = true;
      directories = [
        "/var/log"
        "/var/lib/nixos"
        "/var/lib/systemd/coredump"
        "/etc/NetworkManager/system-connections"
      ];
      files = [
        "/etc/machine-id"
        "/etc/ssh/ssh_host_ed25519_key"
        "/etc/ssh/ssh_host_ed25519_key.pub"
        "/etc/ssh/ssh_host_rsa_key"
        "/etc/ssh/ssh_host_rsa_key.pub"
      ];
    };

    programs.fuse.userAllowOther = true;
  };
}
