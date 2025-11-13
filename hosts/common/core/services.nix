{lib, ...}: {
  # Disabling speechd, the speech dispatcher daemon, as it's not
  # needed for most desktop use cases and can consume resources.
  services.speechd.enable = lib.mkForce false;
  # thermald helps prevent CPU's from overheating.
  services.thermald.enable = true;
  # Power management middleware and reporting.
  services.upower.enable = true;
  # Wrapper service for udisks.
  services.devmon.enable = true;
  # Enable GNOME keyring.
  services.gnome.gnome-keyring.enable = true;
}
