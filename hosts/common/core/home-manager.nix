{
  inputs,
  outputs,
  ...
}: {
  imports = [
    # Import the required inputs.
    inputs.home-manager.nixosModules.home-manager
  ];
  # Home-Manager config.
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "backup";
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
  };
}
