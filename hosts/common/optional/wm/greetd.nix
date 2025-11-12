{
  lib,
  pkgs,
  config,
  ...
}: {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --asterisks --user-menu --cmd niri-session";
        user = "greeter";
      };
    };
  };

  security = {
    pam.services.greetd.enableGnomeKeyring = true;
    polkit.enable = true;
  };
}
