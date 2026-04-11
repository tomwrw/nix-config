{inputs, ...}: let
  hostname = "spectre";
in {
  flake.modules.nixos."${hostname}" = {
    imports = with inputs.self.modules.nixos; [
      tomwrw
    ];
  };
}
