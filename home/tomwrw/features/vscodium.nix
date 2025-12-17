{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles = {
      default = {
        extensions = with pkgs.vscode-extensions; [
          # anthropic.claude-code
          kamadorueda.alejandra
          jnoortheen.nix-ide
          yzhang.markdown-all-in-one
        ];
        userSettings = {
          "git.confirmSync" = false;
          "git.enableSmartCommit" = true;
          "git.autofetch" = true;
          "git.allowForcePush" = true;
          "explorer.confirmDragAndDrop" = false;
          "explorer.confirmDelete" = false;
        };
      };
    };
  };
  # This app requires the following persisted directories
  # and folders. Be This will only apply if impermanence is
  # enabled, and as soon as a user and host become out of
  # scope for this module, the items here will no longer
  # be persisted (they'll still exist in /persist thought).
  home.persistence."/persist" = {
    directories = [
      # Persisted directories go here (if needed).
      ".config/Code"
      ".config/VSCodium"
      ".vscode"
      ".vscode-oss"
    ];
    files = [
      # Persisted files go here (if needed).
    ];
  };
}
