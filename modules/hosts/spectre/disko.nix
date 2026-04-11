# Disk configuration for spectre using disko.
# The primary btrfs volume is labelled 'nixos' and a blank root
# snapshot is created on first install for use with impermanence.
{inputs, ...}: let
  hostname = "spectre";
  diskId = "/dev/vda";
in {
  flake.modules.nixos."${hostname}" = {
    imports = with inputs.self.modules.nixos; [
      disko
    ];

    disko.devices = {
      disk = {
        main = {
          type = "disk";
          device = diskId;
          content = {
            type = "gpt";
            partitions = {
              ESP = {
                size = "1024M";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                  mountOptions = ["umask=0077"];
                };
              };
              luks = {
                size = "100%";
                content = {
                  type = "luks";
                  name = "crypted";
                  # These options can improve performance on NVMe drives by adjusting
                  # how LUKS handles I/O operations.
                  extraOpenArgs = [
                    "--allow-discards"
                    "--perf-no_read_workqueue"
                    "--perf-no_write_workqueue"
                  ];
                  settings = {
                    # TRIM/discard operations on SSDs can leak information about
                    # which blocks are unused, potentially revealing filesystem
                    # structure or metadata patterns. This is a common compromise
                    # for SSD performance and longevity.
                    allowDiscards = true;
                  };
                  content = {
                    type = "btrfs";
                    extraArgs = [
                      "-L"
                      "nixos"
                      "-f"
                    ];
                    postCreateHook = ''
                      mount -t btrfs /dev/disk/by-label/nixos /mnt
                      btrfs subvolume snapshot -r /mnt /mnt/root-blank
                      umount /mnt
                    '';
                    subvolumes = {
                      "/root" = {
                        mountpoint = "/";
                        mountOptions = [
                          "subvol=root"
                          "compress=zstd"
                          "noatime"
                        ];
                      };
                      "/nix" = {
                        mountpoint = "/nix";
                        mountOptions = [
                          "subvol=nix"
                          "compress=zstd"
                          "noatime"
                        ];
                      };
                      "/home" = {
                        mountpoint = "/home";
                        mountOptions = [
                          "subvol=home"
                          "compress=zstd"
                          "noatime"
                        ];
                      };
                      "/persist" = {
                        mountpoint = "/persist";
                        mountOptions = [
                          "subvol=persist"
                          "compress=zstd"
                          "noatime"
                        ];
                      };
                      "/swap" = {
                        mountpoint = "/swap";
                        swap.swapfile.size = "12G";
                      };
                    };
                  };
                };
              };
            };
          };
        };
      };
    };

    fileSystems."/persist".neededForBoot = true;

    # Roll back the root subvolume to a blank snapshot on every boot.
    # Requires the 'root-blank' snapshot created by disko's postCreateHook.
    boot.initrd = {
      enable = true;
      supportedFilesystems = ["btrfs"];
      systemd.services.rollback = {
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
    };
  };
}
