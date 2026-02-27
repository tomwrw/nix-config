{inputs, ...}: {
  # This overlay provides a convenient way to access the packages from all
  # flake inputs. For each input, it creates an attribute set under `pkgs.inputs`
  # (e.g., `pkgs.inputs.spicetify-nix`). This makes it easy to use packages
  # from other flakes in your configuration without having to manually dig
  # through `inputs`. It intelligently looks for `packages` or `legacyPackages`
  # on the flake for the current system.
  flake-inputs = final: _: let
    hostSystem = final.stdenv.hostPlatform.system;
  in {
    inputs =
      builtins.mapAttrs (
        _: flake: let
          # Use the new path for attribute lookups
          legacyPackages = (flake.legacyPackages or {}).${hostSystem} or {};
          packages = (flake.packages or {}).${hostSystem} or {};
        in
          if legacyPackages != {}
          then legacyPackages
          else packages
      )
      inputs;
  };

  # This overlay adds `pkgs.stable` which points to the `nixpkgs-stable`
  # flake input. This allows you to install packages from the stable
  # channel on a system that primarily uses `nixpkgs-unstable`. You can
  # install a stable package with `pkgs.stable.package-name`.
  stable = final: _: {
    stable = inputs.nixpkgs-stable.legacyPackages.${final.stdenv.hostPlatform.system};
  };

  # Temporarily pin sunshine to the stable version. The nixpkgs-unstable build
  # of sunshine (2025.924.154138) attempts to fetch Boost via CMake FetchContent
  # during the build, which fails in Nix's sandbox. Remove this override once
  # the upstream nixpkgs issue is resolved.
  sunshine-stable = final: _: {
    sunshine = final.stable.sunshine;
  };

  # Temporarily disable picosvg tests which are failing in nixpkgs-unstable due
  # to floating-point SVG path value mismatches. picosvg is a transitive
  # dependency of jetbrains-mono (via nanoemoji and gftools). Remove this
  # override once the upstream nixpkgs issue is resolved.
  picosvg-nocheck = _: prev: {
    pythonPackagesExtensions =
      prev.pythonPackagesExtensions
      ++ [
        (_: pysuper: {
          picosvg = pysuper.picosvg.overridePythonAttrs (_: {
            doCheck = false;
          });
        })
      ];
  };

  #linux-firmware-override = final: prev: {
  #  linux-firmware = prev.linux-firmware.overrideAttrs (old: rec {
  #    version = "20250509";
  #    src = prev.fetchzip {
  #      url = "https://cdn.kernel.org/pub/linux/kernel/firmware/linux-firmware-${version}.tar.xz";
  #      hash = "sha256-0FrhgJQyCeRCa3s0vu8UOoN0ZgVCahTQsSH0o6G6hhY=";
  #    };
  #   });
  #};
}
