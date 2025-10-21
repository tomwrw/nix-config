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
  hashedPassword = "$6$SpG3sYsUt3IxXQLv$1v6tnDzULI4mM6bO.jXbJGuO/7rXcfdKJet4xBcylTG88dDyJrGdNpsKH9/eGwVIFSmQD6lIWWWE4CTUAMI820";
  sshKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFCIJ1LhkFDBZaZU/bf8Y3XyCXb3RnVxg4gRs6i+XbSe tomwrw@proton.me";
  # Store the hostname for deriving the home file path.
  hostname = config.networking.hostName;
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.mutableUsers = false;
  users.users.${username} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    hashedPassword = hashedPassword;
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
  };

  home-manager.users.${username} = import ../../../../home/${username}/${hostname}.nix;
}
