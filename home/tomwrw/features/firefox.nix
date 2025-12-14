{
  inputs,
  pkgs,
  ...
}: {
  programs.firefox.enable = true;

  programs.firefox.policies = {
    DontCheckDefaultBrowser = true;
    DisableTelemetry = true;
    DisableFirefoxStudies = true;
    DisablePocket = true;
    DisableFirefoxScreenshots = true;
    DisplayBookmarksToolbar = "never";
    DisplayMenuBar = "never"; # Previously appeared when pressing alt
    PasswordManagerEnabled = false;
    OfferToSaveLogins = false;
    AutofillAddressEnabled = false;
    AutofillCreditCardEnabled = false;
    OverrideFirstRunPage = "";
    PictureInPicture.Enabled = false;
    PromptForDownloadLocation = false;
    HardwareAcceleration = true;
    TranslateEnabled = true;
    Homepage.StartPage = "previous-session";
    UserMessaging = {
      UrlbarInterventions = false;
      SkipOnboarding = true;
    };
    FirefoxSuggest = {
      WebSuggestions = false;
      SponsoredSuggestions = false;
      ImproveSuggest = false;
    };
    EnableTrackingProtection = {
      Value = true;
      Cryptomining = true;
      Fingerprinting = true;
    };
    FirefoxHome = {
      Search = true;
      TopSites = false;
      SponsoredTopSites = false;
      Highlights = false;
      Pocket = false;
      SponsoredPocket = false;
      Snippets = false;
    };
    Handlers.schemes.vscode = {
      action = "useSystemDefault"; # Open VSCode app
      ask = false;
    };
    Handlers.schemes.element = {
      action = "useSystemDefault"; # Open Element app
      ask = false;
    };

    Preferences = {
      "browser.urlbar.suggest.searches" = true; # Need this for basic search suggestions
      "browser.urlbar.shortcuts.bookmarks" = false;
      "browser.urlbar.shortcuts.history" = false;
      "browser.urlbar.shortcuts.tabs" = false;
      "browser.urlbar.placeholderName" = "ddg";
      "browser.urlbar.placeholderName.private" = "ddg";
      "browser.aboutConfig.showWarning" = false; # No warning when going to config
      "browser.warnOnQuitShortcut" = false;
      "browser.tabs.loadInBackground" = true; # Load tabs automatically
      "media.ffmpeg.vaapi.enabled" = true; # Enable hardware acceleration
      "browser.in-content.dark-mode" = true; # Use dark mode
      "ui.systemUsesDarkTheme" = true;
      "extensions.autoDisableScopes" = 0; # Automatically enable extensions
      "extensions.update.enabled" = false;
      "widget.use-xdg-desktop-portal.file-picker" = 1; # Use new gtk file picker instead of legacy one
      "signon.management.page.breach-alerts.enabled" = false;
      "extensions.formautofill.creditCards.enabled" = false;
    };
  };

  programs.firefox.profiles.default = {
    isDefault = true;

    search = {
      force = true;
      default = "ddg";
      engines = {
        google.metaData.hidden = true;
        bing.metaData.hidden = true;
        ebay.metaData.hidden = true;
        amazondotcome-us.metaData.hidden = true;
        wikipedia.metaData.hidden = true;
      };
    };
  };

  # Extensions. Install extensions from firefox-addons
  # which are more secure, verified, than previous xpi method.
  programs.firefox.profiles.default.extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.system}; [
    bitwarden
    multi-account-containers
    kagi-search
    ublock-origin
  ];
  # Configure extension behavior (toolbar pinning, etc.).
  programs.firefox.policies.ExtensionSettings = {
    # Bitwarden - pin to toolbar.
    "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
      installation_mode = "normal_installed";
      default_area = "navbar";
      private_browsing = true;
    };
    # uBlock Origin - pin to toolbar.
    "uBlock0@raymondhill.net" = {
      installation_mode = "normal_installed";
      default_area = "navbar";
      private_browsing = true;
    };
    # Multi-Account Containers - pin to toolbar
    "@testpilot-containers" = {
      installation_mode = "normal_installed";
      default_area = "navbar";
      private_browsing = true;
    };
    # Kagi Search - pin to toolbar
    "search@kagi.com" = {
      installation_mode = "normal_installed";
      default_area = "navbar";
      private_browsing = true;
    };
  };

  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/http" = ["firefox.desktop"];
    "x-scheme-handler/https" = ["firefox.desktop"];
    "text/html" = ["firefox.desktop"];
    "application/pdf" = ["firefox.desktop"];
  };
  # This app requires the following persisted directories
  # and folders. Be This will only apply if impermanence is
  # enabled, and as soon as a user and host become out of
  # scope for this module, the items here will no longer
  # be persisted (they'll still exist in /persist thought).
  home.persistence."/persist" = {
    directories = [
      # Persisted directories go here (if needed).
      ".mozilla"
    ];
    files = [
      # Persisted files go here (if needed).
    ];
  };
}
