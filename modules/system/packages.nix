{inputs, ...}: {
  flake.modules.nixos.packages = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      age
      alejandra
      fastfetch
      fd
      fzf
      jq
      just
      pciutils
      ripgrep
      sbctl
      ssh-to-age
      sops
      unzip
    ];
  };
}
