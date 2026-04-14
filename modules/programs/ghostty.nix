{
  flake.modules.homeManager.ghostty = {
    programs.ghostty = {
      enable = true;
      enableFishIntegration = true;
      installBatSyntax = true;
    };
  };
}
