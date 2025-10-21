{pkgs, ...}: {
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        # Enable software TPM for QEMU
        swtpm.enable = true;
      };
    };
  };

  services = {
    spice-autorandr.enable = true;
    spice-vdagentd.enable = true;
  };

  networking.firewall.trustedInterfaces = ["br0"];

  programs.virt-manager = {
    enable = true;
    package = pkgs.virt-manager;
  };

  environment.persistence."/persist" = {
    directories = [
      "/var/cache/libvirt"
      "/var/lib/libvirt"
      "/var/lib/qemu"
    ];
  };
}
