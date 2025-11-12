{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    inputs.chaotic.nixosModules.default
  ];

  # Apply the chaotic overlay to make chaotic packages available.
  # This overlay provides additional packages from the chaotic-nyx repository,
  # including the CachyOS kernel packages.
  nixpkgs.overlays = [inputs.chaotic.overlays.default];

  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_cachyos;
}
