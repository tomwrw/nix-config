{pkgs, ...}: {
  programs.niri.settings.spawn-at-startup = [
    {command = ["${pkgs.xwayland-satellite}/bin/xwayland-satellite"];}
    {command = ["waybar"];}
    #{command = ["wl-paste" "--watch" "cliphist" "store"];}
    #{command = ["clipsync"];}
  ];
}
