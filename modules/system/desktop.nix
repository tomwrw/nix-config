{inputs, ...}: {
  flake.modules.nixos.desktop = {pkgs, ...}: {
    imports = with inputs.self.modules.nixos; [
      audio
      fonts
      graphics
      locale
      networking
      nix-settings
      openssh
    ];

    programs.dconf.enable = true;
    xdg.portal.enable = true;
  };
}
