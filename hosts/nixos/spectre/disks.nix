# Disk configuration file for disko for the host 'spectre'.
# I also use a postCreateHook to generate a blank
# root snapshot when the host is first created.
{
  config,
  inputs,
  outputs,
  ...
}: let
  diskId = "/dev/vda";
  hostname = config.networking.hostName;
in {
  imports = [
    inputs.disko.nixosModules.disko
  ];

  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "${diskId}";
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
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = ["-L" "${hostname}" "-f"];
                postCreateHook = ''
                  mount -t btrfs /dev/disk/by-label/${hostname} /mnt
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
  fileSystems."/persist".neededForBoot = true;
}
