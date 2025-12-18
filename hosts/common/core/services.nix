{lib, ...}: {
  services = {
    # Disabling speechd, the speech dispatcher daemon, as it's not
    # needed for most desktop use cases and can consume resources.
    speechd.enable = lib.mkForce false;
    # thermald helps prevent CPU's from overheating.
    thermald.enable = true;
    # Power management middleware and reporting.
    upower.enable = true;
    # Wrapper service for udisks.
    devmon.enable = true;
    # Enable GNOME keyring.
    gnome.gnome-keyring.enable = true;
  };
}
