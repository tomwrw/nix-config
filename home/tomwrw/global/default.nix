{outputs, ...}: {
  imports =
    [
      # Removed alacritty in favour of ghostty.
      #./alacritty.nix
      ./btop.nix
      ./ghostty.nix
      ./git.nix
      ./home-manager.nix
      ./neovim.nix
      ./packages.nix
      ./persists.nix
      ./stylix.nix
      ./zsh.nix
    ]
    # Include any custom Home Manager modules I have defined.
    ++ (builtins.attrValues outputs.homeManagerModules);
}
