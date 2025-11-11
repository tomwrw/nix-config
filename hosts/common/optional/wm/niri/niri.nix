{
  inputs,
  pkgs,
  lib,
  ...
}: {
  # imports = [
  #   ../gdm.nix
  # ];
  nixpkgs.overlays = [inputs.niri.overlays.niri];
  # Enable niri.
  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };

  # Enable XDG desktop portal for niri.
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
    config = {
      niri = {
        default = [
          "gnome"
          "gtk"
        ];
        "org.freedesktop.impl.portal.Screenshot" = ["gnome"];
        "org.freedesktop.impl.portal.Screencast" = ["gnome"];
      };
    };
  };

  # Session management and authentication
  security = {
    # PAM configuration for screen locking
    pam.services = {
      login.enableGnomeKeyring = true;
      hyprlock = {};
    };

    # Polkit for privilege escalation
    polkit.enable = true;
    rtkit.enable = true;
  };

  # Niri-specific environment variables
  environment.sessionVariables = {
    XDG_CURRENT_DESKTOP = lib.mkDefault "niri";
    XDG_SESSION_DESKTOP = lib.mkDefault "niri";
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };

  # Services configuration
  services = {
    # Enable dbus for proper IPC
    dbus.enable = true;

    # Enable udev for device management
    udev.enable = true;
    udev.packages = with pkgs; [
      gnome-settings-daemon # For consistent hardware handling
    ];

    # Power management
    upower.enable = true;
    thermald.enable = true;

    # Printing (if needed)
    printing.enable = false;

    # Location services (for gammastep/redshift)
    geoclue2.enable = true;

    # Thumbnail generation
    tumbler.enable = true;

    # GNOME keyring (for credential management)
    gnome.gnome-keyring.enable = true;

    # Auto-mounting
    gvfs.enable = true;
    udisks2.enable = true;

    # Firmware updates
    fwupd.enable = true;
  };

  # Systemd configuration for better Wayland integration.
  systemd = {
    user.extraConfig = ''
      DefaultEnvironment="PATH=/run/current-system/sw/bin"
    '';
  };
}
