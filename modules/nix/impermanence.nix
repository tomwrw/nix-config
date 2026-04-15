{inputs, ...}: {
  flake-file.inputs = {
    impermanence.url = "github:nix-community/impermanence";
  };

  flake.modules.nixos.impermanence = {lib, ...}: {
    imports = [
      inputs.impermanence.nixosModules.impermanence
    ];

    # Needed for rollback service.
    boot.initrd.systemd.enable = true;

    # Roll back the root subvolume to a blank snapshot on every boot.
    # Assumes disko provides a btrfs filesystem labelled 'nixos' with a
    # 'root' subvolume and a 'root-blank' read-only snapshot.
    boot.initrd.systemd.services.rollback = {
      description = "Rollback BTRFS root subvolume to a pristine state";
      wantedBy = ["initrd.target"];
      requires = ["dev-disk-by\\x2dlabel-nixos.device"];
      after = [
        "dev-disk-by\\x2dlabel-nixos.device"
        "systemd-cryptsetup@crypted.service"
      ];
      before = ["sysroot.mount"];
      unitConfig.DefaultDependencies = "no";
      serviceConfig.Type = "oneshot";
      script = ''
        mkdir /mnt
        mount -t btrfs -o subvol=/ /dev/disk/by-label/nixos /mnt
        btrfs subvolume list -o /mnt/root | cut -f 9- -d ' ' | while read subvolume; do
          echo "deleting subvolume: /$subvolume..."
          btrfs subvolume delete "/mnt/$subvolume" 1>/dev/null
        done &&
        btrfs subvolume delete /mnt/root 1>/dev/null
        echo "restoring blank /root subvolume..."
        btrfs subvolume snapshot /mnt/root-blank /mnt/root 1>/dev/null
        rm -rf /mnt/root/root && mkdir /mnt/root/root
        umount /mnt
      '';
    };

    # If using impermanence, mutableUsers must be false.
    users.mutableUsers = false;

    # Again, if using impermanence, this will alter the sops keyFile path.
    sops.age.keyFile = lib.mkForce "/persist/var/lib/sops-nix/key.txt";

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
  };
}
