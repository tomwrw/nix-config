{
  inputs,
  outputs,
  ...
}: {
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      ./gnupg.nix
      ./hardware.nix
      ./locale.nix
      ./network.nix
      ./nix.nix
      ./packages.nix
      ./persistence.nix
      ./security.nix
      ./ssh.nix
      ./systemd-initrd.nix
      ./zsh.nix
    ]
    ++ (builtins.attrValues outputs.nixosModules);

  # Home-manager config.
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "backup";
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
  };
}
