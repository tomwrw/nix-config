{
  config,
  lib,
  osConfig,
  ...
}: let
  # Get the current host name from NixOS config.
  currentHost = osConfig.networking.hostName;
  # Define my Syncthing hosts with thier Syncthing ID.
  hostIdentifiers = {
    endgame = "Q33QSQU-MHSJEKX-4TX7NBE-CK7LQXE-BHZVZQZ-VJRCYLF-QHTWM3P-T26FQAM";
    flatmate = "PH677EH-LEEWWU7-4PGWHJH-6BFBGOQ-4JVUZYA-GLMJK6A-ELSFFW3-GOV5UAS";
    spectre = "SFGQOLQ-QEK4P42-P5IVTBB-QE7KIXY-OVRLAUL-WIBTMGE-ISDPK6P-XK6A4Q5";
  };
  # Helper to get the list of hostnames as
  # [ "endgame" "flatmate" "spectre" ].
  allHosts = builtins.attrNames hostIdentifiers;
in {
  # Secrets use defaultSopsFile and age.sshKeyPaths
  # from global/sops.nix
  sops.secrets = {
    "syncthing/${currentHost}/key" = {};
    "syncthing/${currentHost}/cert" = {};
    "syncthing/guiPassword" = {};
  };
  # Configure the Syncthing service.
  services.syncthing = {
    enable = true;
    # Key and Cert prevents the need to accept sharing
    # with devices in my config. They are stored in the
    # secrets file.
    key = config.sops.secrets."syncthing/${currentHost}/key".path;
    cert = config.sops.secrets."syncthing/${currentHost}/cert".path;
    # The password file is used for the GUI password.
    # Also stored in the secrets file.
    passwordFile = config.sops.secrets."syncthing/guiPassword".path;
    settings = {
      # Couldn't easily store the username for the GUI
      # in the secrets file as the home-manager module
      # doesn't store the user as a path, but as a plain
      # string instead. Not too worried about sharing this.
      gui = {
        user = "admin";
      };
      # Syncthing kicks up a stink if partial config is
      # already present on a device, so these options force
      # override. This was presenting as a device not reading
      # it's secrets properly and asking for user to accept
      # device sharing, exactly what keys and certs are
      # designed to avoid.
      overrideDevices = true;
      overrideFolders = true;
      # Generate the devices block from the hostIdentifiers.
      devices = lib.mapAttrs (name: id: {inherit id;}) hostIdentifiers;
      # Specify additional options for Syncthing here.
      options = {
        # Keep traffic local and disable external relay/discovery.
        relaysEnabled = false; # Don't use relay servers.
        globalAnnounceEnabled = false; # Don't announce to global discovery.
        localAnnounceEnabled = true; # Keep local/LAN discovery.
        natEnabled = false; # No NAT traversal needed on local network.
        urAcceptedStr = "-1"; # Disable usage reporting prompts.
      };
      # Syncthing folder definitions go here.
      folders = {
        # Sync - my primary sync folder on all hosts.
        "Sync" = {
          path = "${config.home.homeDirectory}/Sync";
          # Use the list of all keys from the hostIdentifiers map.
          devices = allHosts;
          # File versioning to keep deleted/modified file history.
          versioning = {
            type = "staggered";
            params = {
              # Check for old versions every hour.
              cleanInterval = "3600";
              # Keep versions for 30 days (in seconds).
              maxAge = "2592000";
            };
          };
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
      "Sync"
    ];
    files = [
      # Persisted files go here (if needed).
    ];
  };
}
