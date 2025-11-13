{
  # Enable rtkit and polkit for all hosts.
  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };
  # Enable passwordless sudo for members
  # of wheel group.
  security.sudo = {
    enable = true;
    extraRules = [
      {
        commands = [
          {
            command = "ALL";
            options = ["NOPASSWD"];
          }
        ];
        groups = ["wheel"];
      }
    ];
  };
  # Enable PAM security settings for all hosts.
  security.pam = {
    # Enable the logon unlock of GNOME keyring.
    services.login.enableGnomeKeyring = true;
    # The default open file limit is often too low for modern applications,
    # especially for development, gaming, and other intensive tasks. Increasing
    # this limit prevents "too many open files" errors.
    loginLimits = [
      {
        domain = "@wheel";
        item = "nofile";
        type = "soft";
        value = "524288";
      }
      {
        domain = "@wheel";
        item = "nofile";
        type = "hard";
        value = "1048576";
      }
    ];
  };
}
