{pkgs, ...}: {
  # Packages installed on all hosts go here.
  environment.systemPackages = with pkgs; [
    alejandra
    easyeffects
    fd
    fzf
    gnome-keyring
    jq
    just
    pciutils
    ripgrep
    sbctl
    seahorse
    ssh-to-age
    sops
    unzip
  ];
  # Fonts installed on all hosts go here.
  fonts.packages = with pkgs; [
    dejavu_fonts
    fira-code
    hack-font
    ibm-plex
    inconsolata
    jetbrains-mono
    liberation_ttf
    nerd-fonts.dejavu-sans-mono
    nerd-fonts.caskaydia-mono
    noto-fonts
    roboto
    roboto-mono
    source-code-pro
    ttf_bitstream_vera
  ];
}
