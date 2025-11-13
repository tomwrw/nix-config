{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    # Import the required inputs.
    inputs.chaotic.nixosModules.default
  ];
  # Apply the chaotic overlay to make chaotic packages available.
  # This overlay provides additional packages from the chaotic-nyx repository,
  # including the CachyOS kernel packages.
  nixpkgs.overlays = [inputs.chaotic.overlays.default];
  # Switch out the default kernel for the cachyos one.
  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_cachyos;
}
