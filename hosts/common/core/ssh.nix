{
  config,
  lib,
  outputs,
  ...
}: let
  hosts = lib.attrNames outputs.nixosConfigurations;
  inherit (config.networking) domain;
  # Sops needs acess to the keys before the persist dirs are even mounted; so
  # just persisting the keys won't work, we must point at /persist
  hasOptinPersistence = config.environment.persistence ? "/persist";
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
    };
    # Format and path for the auto-generated host
    # ssh keys. If persistance is used map to persist.
    # This is also required for the sops.nix module as
    # I iterate over hostKeys to provide sops keyPaths.
    hostKeys = [
      {
        path = "${lib.optionalString hasOptinPersistence "/persist"}/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };
  # Add the public key of each of my hosts to the config.
  programs.ssh = {
    # Each hosts public key.
    knownHosts = lib.genAttrs hosts (hostname: {
      publicKeyFile = ../../nixos/${hostname}/keys/ssh_host_ed25519_key.pub;
      extraHostNames =
        [
          "${hostname}.${domain}"
        ]
        ++
        # Alias for localhost if it's the same host.
        (lib.optional (hostname == config.networking.hostName) "localhost");
    });
  };
  # Passwordless sudo when SSH'ing with keys.
  security.pam.sshAgentAuth = {
    enable = true;
    authorizedKeysFiles = ["/etc/ssh/authorized_keys.d/%u"];
  };
}
