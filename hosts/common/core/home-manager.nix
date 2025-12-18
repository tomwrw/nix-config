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
  home-manager = {
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = {
      inherit inputs outputs;
    };
  };
}
