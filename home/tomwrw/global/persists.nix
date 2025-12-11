{inputs, ...}: {
  imports = [
    # Import the Home Manager impermanence module in case
    # we have it declared for our system.
    inputs.impermanence.homeManagerModules.impermanence
  ];
  # Global persists for anything that could be global
  # or optional for Home Manager configs, like Steam.
  home.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "Development"
      "Documents"
      "Downloads"
      "Music"
      "Pictures"
      "Vaults"
      "Videos"
      ".openvpn"
      ".password-store"
      ".themes"
      ".config/sunshine"
      ".config/dconf"
      ".config/openrazer"
      ".config/polychromatic"
      ".config/sops"
      ".local/share/nix"
      ".local/state"
      ".local/share/Steam"
      ".local/share/direnv"
      ".local/share/PrismLauncher"
      ".steam"
      ".cache/virt-manager"
      {
        directory = ".ssh";
        mode = "0700";
      }
      {
        directory = ".pki";
        mode = "0700";
      }
      {
        directory = ".gnupg";
        mode = "0700";
      }
      {
        # Keyrings store passwords and other secrets for applications.
        # Persisting this is important for not having to log in repeatedly.
        directory = ".local/share/keyrings";
        mode = "0700";
      }
    ];
    files = [
      #".face"
      ".screenrc"
    ];
  };
}
