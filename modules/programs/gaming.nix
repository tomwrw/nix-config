{
  flake.modules.nixos.gaming = {pkgs, ...}: {
    nixpkgs.overlays = [
      (_: prev: {
        gamescope = prev.gamescope.overrideAttrs (_: {
          # https://github.com/ValveSoftware/gamescope/issues/1924#issuecomment-3725667842
          NIX_CFLAGS_COMPILE = ["-fno-fast-math"];
        });
      })
    ];

    services.udev.packages = [pkgs.sunshine];
    services.sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true;
      openFirewall = true;
    };

    hardware.steam-hardware.enable = true;

    programs = {
      gamemode.enable = true;
      steam = {
        enable = true;
        gamescopeSession.enable = true;
        extraCompatPackages = [pkgs.proton-ge-bin];
        extraPackages = [pkgs.gamemode];
      };
    };

    environment.systemPackages = with pkgs; [
      game-devices-udev-rules
    ];

    # Taken from https://github.com/fufexan/nix-gaming.
    boot.kernel.sysctl = {
      # 20-shed.conf
      "kernel.sched_cfs_bandwidth_slice_us" = 3000;
      # 20-net-timeout.conf
      # Required because some games cannot reuse their TCP ports if killed
      # and restarted quickly — the default timeout is too large.
      "net.ipv4.tcp_fin_timeout" = 5;
      # 30-splitlock.conf
      # Prevents intentional slowdowns in case games experience split locks
      # (valid for kernels v6.0+).
      "kernel.split_lock_mitigate" = 0;
      # 30-vm.conf
      # USE MAX_INT - MAPCOUNT_ELF_CORE_MARGIN.
      # See comment in include/linux/mm.h in the kernel tree.
      "vm.max_map_count" = 2147483642;
    };
  };

  flake.modules.homeManager.gaming = {pkgs, ...}: {
    programs = {
      lutris = {
        enable = true;
        protonPackages = [pkgs.proton-ge-bin];
      };
      mangohud = {
        enable = true;
        enableSessionWide = false;
      };
    };
  };
}
