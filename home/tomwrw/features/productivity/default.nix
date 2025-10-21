{pkgs, ...}: {
  imports = [
    ./bitwarden.nix
    ./ente.nix
    ./firefox.nix
    ./obsidian.nix
  ];
}
