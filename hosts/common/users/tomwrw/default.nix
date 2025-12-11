{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
with lib; let
  # TODO: Add your username, hashed password and ssh key.
  username = "tomwrw";
  sshKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFCIJ1LhkFDBZaZU/bf8Y3XyCXb3RnVxg4gRs6i+XbSe tomwrw@proton.me";
  # Store the hostname for deriving the home file path.
  hostname = config.networking.hostName;
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.mutableUsers = false;
  users.users.${username} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [sshKey];
    packages = [pkgs.home-manager];
    extraGroups = ifTheyExist [
      "audio"
      "docker"
      "git"
      "i2c"
      "libvirtd"
      "mysql"
      "network"
      "plugdev"
      "podman"
      "openrazer"
      "video"
      "vboxusers"
      "wheel"
      "kvm"
    ];
    # This uses the sops-nix managed password for my user.
    hashedPasswordFile = config.sops.secrets.password-tomwrw.path;
  };
  # Read the sops managed secret for my user password.
  sops.secrets.password-tomwrw = {
    sopsFile = ../../../../secrets/secrets.yaml;
    neededForUsers = true;
  };
  # Import the Home Manager config for this user on this host.
  home-manager.users.${username} = import ../../../../home/${username}/${hostname}.nix;
}
