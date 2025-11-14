{config, ...}: let
  hostname = config.networking.hostName;
in {
  services.openssh = {
    enable = true;
    settings = {
      # Harden ssh.
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      # Automatically remove stale sockets.
      StreamLocalBindUnlink = "yes";
      # Allow forwarding ports to everywhere.
      GatewayPorts = "clientspecified";
      # Let WAYLAND_DISPLAY be forwarded.
      AcceptEnv = "WAYLAND_DISPLAY";
      X11Forwarding = true;
    };
    # Format and path for the auto-generated host
    # ssh keys. I like to use the hostname as a comment.
    hostKeys = [
      {
        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
        comment = hostname;
      }
    ];
  };
  # Passwordless sudo when SSH'ing with keys.
  security.pam.sshAgentAuth = {
    enable = true;
    authorizedKeysFiles = ["/etc/ssh/authorized_keys.d/%u"];
  };
}
