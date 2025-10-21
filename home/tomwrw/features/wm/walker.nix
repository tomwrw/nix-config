{
  pkgs,
  config,
  inputs,
  ...
}: {
  services.walker = {
    enable = true;
    settings = {
      text = ''
        close_when_open = true
        theme = "nix"
        theme_base = []
        hotreload_theme = true
        force_keyboard_focus = true
        timeout = 60

        [keys.ai]
        run_last_response = ["ctrl e"]

        [list]
        max_entries = 200
        cycle = true

        [search]
        placeholder = " Search..."

        [builtins.hyprland_keybinds]
        path = "~/.config/hypr/hyprland.conf"
        hidden = true

        [builtins.applications]
        launch_prefix = "uwsm app -- "
        placeholder = " Search..."
        prioritize_new = false
        context_aware = false
        show_sub_when_single = false
        history = false
        icon = ""
        hidden = true

        [builtins.applications.actions]
        enabled = false
        hide_category = true

        [builtins.bookmarks]
        hidden = true

        [builtins.calc]
        name = "Calculator"
        icon = ""
        min_chars = 3
        prefix = "="

        [builtins.windows]
        switcher_only = true
        hidden = true

        [builtins.clipboard]
        hidden = true

        [builtins.commands]
        hidden = true

        [builtins.custom_commands]
        hidden = true

        [builtins.emojis]
        name = "Emojis"
        icon = ""
        prefix = ":"

        [builtins.symbols]
        after_copy = ""
        hidden = true

        [builtins.finder]
        use_fd = true
        cmd_alt = "xdg-open $(dirname ~/%RESULT%)"
        icon = "file"
        name = "Finder"
        preview_images = true
        hidden = false
        prefix = "."

        [builtins.runner]
        shell_config = ""
        switcher_only = true
        hidden = true

        [builtins.ssh]
        hidden = true

        [builtins.websearch]
        switcher_only = true
        hidden = true

        [builtins.translation]
        hidden = true
      '';
    };
    theme.style = ''
      @define-color selected-text ${config.lib.stylix.colors.withHashtag.base08};
      @define-color text ${config.lib.stylix.colors.withHashtag.base04};
      @define-color base ${config.lib.stylix.colors.withHashtag.base02};
      @define-color border ${config.lib.stylix.colors.withHashtag.base08};
      @define-color foreground ${config.lib.stylix.colors.withHashtag.base05};
      @define-color background ${config.lib.stylix.colors.withHashtag.base00};

      /* Reset all elements */
      #window,
      #box,
      #search,
      #password,
      #input,
      #prompt,
      #clear,
      #typeahead,
      #list,
      child,
      scrollbar,
      slider,
      #item,
      #text,
      #label,
      #sub,
      #activationlabel {
        all: unset;
      }

      * {
        font-family: monospace;
        font-size: 18px;
      }

      /* Window */
      #window {
        background: transparent;
        color: @text;
      }

      /* Main box container */
      #box {
        background: alpha(@base, 0.95);
        padding: 20px;
        border: ${builtins.toString config.theme.borderWidth}px solid @border;
        border-radius: 0px;
      }

      /* Search container */
      #search {
        background: @base;
        padding: 10px;
        margin-bottom: 0;
      }

      /* Hide prompt icon */
      #prompt {
        opacity: 0;
        min-width: 0;
        margin: 0;
      }

      /* Hide clear button */
      #clear {
        opacity: 0;
        min-width: 0;
      }

      /* Input field */
      #input {
        background: none;
        color: @text;
        padding: 0;
      }

      #input placeholder {
        opacity: 0.5;
        color: @text;
      }

      /* Hide typeahead */
      #typeahead {
        opacity: 0;
      }

      /* List */
      #list {
        background: transparent;
      }

      /* List items */
      child {
        padding: 0px 12px;
        background: transparent;
        border-radius: 0;
      }

      child:selected,
      child:hover {
        background: transparent;
      }

      /* Item layout */
      #item {
        padding: 0;
      }

      #item.active {
        font-style: italic;
      }

      /* Icon */
      #icon {
        margin-right: 10px;
        -gtk-icon-transform: scale(0.7);
      }

      /* Text */
      #text {
        color: @text;
        padding: 14px 0;
      }

      #label {
        font-weight: normal;
      }

      /* Selected state */
      child:selected #text,
      child:selected #label,
      child:hover #text,
      child:hover #label {
        color: @selected-text;
      }

      /* Hide sub text */
      #sub {
        opacity: 0;
        font-size: 0;
        min-height: 0;
      }

      /* Hide activation label */
      #activationlabel {
        opacity: 0;
        min-width: 0;
      }

      /* Scrollbar styling */
      scrollbar {
        opacity: 0;
      }

      /* Hide spinner */
      #spinner {
        opacity: 0;
      }

      /* Hide AI elements */
      #aiScroll,
      #aiList,
      .aiItem {
        opacity: 0;
        min-height: 0;
      }

      /* Bar entry (switcher) */
      #bar {
        opacity: 0;
        min-height: 0;
      }

      .barentry {
        opacity: 0;
      }
    '';
  };
}
