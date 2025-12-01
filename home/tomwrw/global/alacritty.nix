{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        # decorations = "none";
        dimensions = {
          columns = 70;
          lines = 17;
        };
        padding = {
          x = 20;
          y = 20;
        };
      };
      scrolling = {
        history = 10000;
        multiplier = 3;
      };
      cursor = {
        style = "Block";
        unfocused_hollow = true;
      };
    };
  };
}
