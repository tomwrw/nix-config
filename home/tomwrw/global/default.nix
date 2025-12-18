{outputs, ...}: {
  imports =
    [
      ./btop.nix
      ./ghostty.nix
      ./git.nix
      ./home-manager.nix
      ./neovim.nix
      ./packages.nix
      ./persists.nix
      ./sops.nix
      ./stylix.nix
      ./zsh.nix
    ]
    # Include any custom Home Manager modules I have defined.
    ++ (builtins.attrValues outputs.homeManagerModules);
}
