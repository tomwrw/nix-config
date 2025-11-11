{
  services.displayManager.gdm.enable = true;
  # Session management and authentication
  security = {
    # PAM configuration for screen locking
    pam.services = {
      gdm.enableGnomeKeyring = true;
    };
  };
}
