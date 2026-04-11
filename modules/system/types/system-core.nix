{inputs, ...}: {
  flake.modules.nixos.system-core = {
    imports = with inputs.self.modules.nixos; [
      system-base
      system-locale
      system-networking
      openssh
    ];
  };

  flake.modules.darwin.system-core = {
    imports = with inputs.self.modules.darwin; [
      system-base
      system-locale
      system-networking
    ];
  };
}
