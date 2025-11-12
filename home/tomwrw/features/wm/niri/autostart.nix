{pkgs, ...}: {
  programs.niri.settings.spawn-at-startup = [
    {command = ["${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"];}
    {command = ["${pkgs.xwayland-satellite}/bin/xwayland-satellite"];}
    {command = ["waybar"];}
    #{command = ["wl-paste" "--watch" "cliphist" "store"];}
    #{command = ["clipsync"];}
  ];
}
