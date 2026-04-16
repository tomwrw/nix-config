{inputs, ...}: {
  flake.modules.nixos.desktop = {
    imports = with inputs.self.modules.nixos; [
      audio
      fonts
      graphics
      locale
      networking
      nix-settings
      openssh
      packages
      sops
    ];
  };
}
