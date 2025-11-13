{
  lib,
  inputs,
  config,
  ...
}: {
  imports = [inputs.impermanence.nixosModules.impermanence];

  environment.persistence."/persist" = {
    hideMounts = true;
    directories =
      [
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
      ]
      ++ lib.optionals config.services.udisks2.enable ["/var/lib/udisks2"]
      ++ lib.optionals config.services.upower.enable ["/var/lib/upower"];
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
