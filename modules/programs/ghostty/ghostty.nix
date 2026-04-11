{...}: {
  flake.modules.homeManager.ghostty = {
    programs.ghostty = {
      enable = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      installBatSyntax = true;
    };
  };
}
