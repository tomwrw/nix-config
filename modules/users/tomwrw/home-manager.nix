{inputs, ...}: let
  username = "tomwrw";
in {
  flake.modules.homeManager."${username}" = {pkgs, ...}: {
    imports = with inputs.self.modules.homeManager; [
      system-cli
      fish
      ghostty
    ];
    home.username = "${username}";
    home.homeDirectory = "/home/${username}";
    home.stateVersion = "25.11";
  };
}
