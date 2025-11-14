{outputs, ...}: {
  imports =
    [
      ./gnupg.nix
      ./hardware.nix
      ./home-manager.nix
      ./locale.nix
      ./network.nix
      ./nix.nix
      ./packages.nix
      ./persists.nix
      ./security.nix
      ./ssh.nix
      ./systemd-initrd.nix
      ./zsh.nix
    ]
    # Include any custom NixOS modules I have defined.
    ++ (builtins.attrValues outputs.nixosModules);
}
