{
  flake.modules.nixos.virt-manager = {pkgs, ...}: {
    virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          # Enable software TPM for QEMU.
          swtpm.enable = true;
        };
      };
    };

    services = {
      spice-autorandr.enable = true;
      spice-vdagentd.enable = true;
    };

    programs.virt-manager = {
      enable = true;
      package = pkgs.virt-manager;
    };
    # This will only apply if impermanence is enabled, and as soon
    # as a user and host become out of scope for this module, the
    # items here will no longer be persisted (they'll still exist
    # in /persist though).
    environment.persistence."/persist" = {
      directories = [
        "/var/cache/libvirt"
        "/var/lib/libvirt"
        "/var/lib/qemu"
      ];
    };
  };
}
