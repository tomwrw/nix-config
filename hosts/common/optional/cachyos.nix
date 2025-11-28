{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    # Import the required inputs.
    inputs.chaotic.nixosModules.nyx-cache
    inputs.chaotic.nixosModules.nyx-overlay
    inputs.chaotic.nixosModules.nyx-registry
  ];
  # Enable use of the nyx cache. Default is true anyway,
  # but no harm in setting it just in case.
  chaotic.nyx.cache.enable = true;
  # Switch out the default kernel for the cachyos one.
  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_cachyos;
}
