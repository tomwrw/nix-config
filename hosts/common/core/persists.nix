{inputs, ...}: {
  imports = [
    # Import the NixOS impermanence module in case
    # we have it declared for our system.
    inputs.impermanence.nixosModules.impermanence
  ];
  # Global persists for anything that could be global
  # or optional for NixOS configs, like lanzaboote.
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/etc/NetworkManager/system-connections"
      "/etc/nixos"
      "/etc/wireguard"
      "/var/cache/tuigreet"
      "/var/db/sudo/lectured"
      "/var/lib/nixos"
      "/var/lib/alsa"
      "/var/lib/systemd"
      "/usr/systemd-placeholder"
      "/var/lib/sbctl"
      "/var/lib/udisks2"
      "/var/lib/upower"
    ];
    files = [
      # The machine-id is a unique identifier for the system, generated
      # during installation. Persisting it is crucial for services like
      # systemd's journal to function correctly across reboots.
      "/etc/machine-id"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
    ];
  };
}
