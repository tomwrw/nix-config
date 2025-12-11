{
  inputs,
  config,
  ...
}: let
  keyType = k: k.type == "ed25519";
  getKeyPath = k: k.path;
  keys = builtins.filter keyType config.services.openssh.hostKeys;
in {
  imports = [
    # Import the required inputs.
    inputs.sops-nix.nixosModules.sops
  ];
  # Setup the keypath for sops to access the
  # required ssh keys on a host.
  sops = {
    age.sshKeyPaths = map getKeyPath keys;
  };
}
