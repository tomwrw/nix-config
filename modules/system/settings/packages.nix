{
  flake.modules.nixos.system-packages = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      fastfetch
      ripgrep
    ];
  };

  flake.modules.darwin.system-packages = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      fastfetch
      ripgrep
    ];
  };

  flake.modules.homeManager.system-packages = {pkgs, ...}: {
    home.packages = with pkgs; [
      fastfetch
      ripgrep
    ];
  };
}
