{
  inputs,
  outputs,
  ...
}: {
  imports =
    [
      ./gnupg.nix
      ./hardware.nix
      ./home-manager.nix
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
}
