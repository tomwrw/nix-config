{
  config,
  lib,
  pkgs,
  ...
}: let
  # 1. Filter out disabled monitors and select only the enabled ones
  enabledMonitors = lib.filter (m: m.enabled) config.monitors;

  # 2. Function to convert a single monitor definition into the Niri attribute pair.
  # This uses lib.nameValuePair to structure the output correctly.
  toNiriOutputAttr = monitor:
    lib.nameValuePair monitor.name {
      # Niri's 'mode' attribute set
      mode = {
        width = monitor.width;
        height = monitor.height;
        # Note: Your module option is 'refresh', Niri's setting is 'refresh'.
        refresh = monitor.refresh;
      };
      # Niri's top-level attributes
      scale = monitor.scale;
      position.x = monitor.posx;
      position.y = monitor.posy;
      # Niri does not use 'primary', 'workspace', etc., in its output configuration,
      # so we omit them.
    };

  # 3. Convert the list of monitor attribute sets into the final attribute set
  # required by programs.niri.settings.outputs.
  niriOutputs = lib.listToAttrs (lib.map toNiriOutputAttr enabledMonitors);
in {
  programs.niri.settings.outputs = niriOutputs;
}
