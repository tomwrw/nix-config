{pkgs, ...}: {
  # graphics drivers / HW accel.
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      libva
      vaapiVdpau
      mesa
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      vaapiVdpau
    ];
  };
}
