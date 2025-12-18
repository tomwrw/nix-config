{
  inputs,
  config,
  ...
}: {
  imports = [
    # Import the required inputs.
    inputs.sops-nix.homeManagerModules.sops
  ];
  # Setup the keypath for sops to access the
  # required user age key for decryption.
  sops = {
    defaultSopsFile = ../../../secrets/secrets.yaml;
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
  };
}
