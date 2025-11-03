{pkgs, ...}: {
  # graphics drivers / HW accel.
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      libva
      libva-vdpau-driver
      mesa
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      libva-vdpau-driver
    ];
  };
}
