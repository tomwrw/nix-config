<p align="center">
  <a href="https://nixos.org/"><img src="https://img.shields.io/badge/NixOS-25.11-blue?style=for-the-badge&logo=NixOS" alt="NixOS"></a>
  <a href="https://github.com/nix-community/home-manager"><img src="https://img.shields.io/badge/Home--Manager-25.11-blue?style=for-the-badge&logo=Home-Assistant" alt="Home Manager"></a>
</p>

# Introduction.

My modular, flake-based repo for managing my systems using Nix and NixOS, flakes and Home Manager (as a NixOS module). I publish my nix-config to help others, as I found Github and other peoples repos (some shoutouts below!) extremely helpful to learn Nix/NixOS. Hopefully I can return the favour by publishing my own, for those who come after.

> **Note:** Though I use this repo for my own config, I also dabble and break things from time to time. I tend to keep working code in the `main` branch. Any other branch, assume it is a work in progress and not suitable for use. Also note that as this is my primary personal config, my `hardware-configuration.nix` files and attributes like `hostname`, `hashedPassword` and `username` will be unique to me, so you'll have to bring your own.

## About.

This is my personal system configuration repo that I use to build systems and homes in conjunction with NixOS, Home Manager and flakes. I started out this journey based on sheer curiosity and a desire to have a somewhat declaritive composition to system management (I distro hop - a lot). Some searching online lead me down the garden path that is NixOS, and here I am. Down the rabbit hole.

I am not an expert in Nix, NixOS, Home Manager or flakes. Nor am I a developer. Outside of my consultancy job (in a technical field so not completely in the dark), I'm a tinkerer. I'd been feeling a little burnt out and in need of something to learn in my downtime, and this project came along at the perfect time, and has genuinely brought some fun back in to computing for me. Just like the days of old, going to the local monthly computer market and picking up a fresh copy of a new Linux distro on a wad of floppies and taking it for a spin.

## Features.

- :desktop_computer: **NixOS** system configuration on mulitple hosts.
- :house: **Home Manager** user configuration for my user.
- :ghost: **sops-nix** for secrets management.
- :camera_flash: **Optional Impermanence** with LUKS encrypted btrfs snapshot and rollback.
- :cop: **Optional Secure Boot** with lanzaboote, including support for dual boot with Windows.
- :snowflake: **Flakes** and modular configs.
- :floppy_disk: **Disko** for disk partioning and preperation.
- :anger: **Chaotic** inputs for CachyOS kernel.
- :paintbrush: **Custom theme module** for themeing to centralise all theme customisation.

## Usage.

This configuration has a multiple system entry points, with Home Manager configured as a NixOS module. At the moment, I am a single user managing multiple machines (I expect this to grow).

### Getting Started.

To deploy a configuration, you can use the `nixos-rebuild` command with the appropriate flake output. For example, to deploy the `endgame` configuration...

```bash
# To build the configuration
nixos-rebuild build --flake .#endgame

# To test the configuration
nixos-rebuild test --flake .#endgame

# To apply the configuration to an existing host.
sudo nixos-rebuild switch --flake .#endgame

# To deploy the configuration for endgame from a remote machine as a bare metal deployment from the NixOS minimal livecd (make sure to set a password with with passwd).
just endgame-deploy

# To rebuild endgame from a remote system.
just endgame-rebuild
```
### Updating.

To update the flake inputs (e.g., `nixpkgs`), run the following command:

```bash
nix flake update
```

### Configuring sops-nix.

I use sops-nix for secrets in this configuration. One example being my user password. I use host SSH keys to decrypt the secrets. All my host SSH keys are added as keys in .sops.yaml. Since I use nixos-anywhere for deployment (bare metal host deployment) and impermanence, this presents a challenge. The target host keys don't exist at the time of deployment, so the host will build, but won't add my user, since it can't decrypt the password. This leaves the device in an unusable state.

To work around this, I use the nixos-anywhere feature ```--extra-files```. This feature allows you to specify files on the build host that will get copied over to the target host during deployment. For this to work, follow these steps:

1. Copy my target host keys from one of my encrypted USB keys to ```/tmp/target_host_name```.
2. Run these commands.

```bash
# Create the directory structure for extra files (if not using impermanence, drop the persist folder)
mkdir -p /tmp/extra-files/persist/etc/ssh

# Copy the pre-generated keys
cp /tmp/target_host_name/ssh_host_ed25519_key /tmp/extra-files/persist/etc/ssh/
cp /tmp/target_host_name/ssh_host_ed25519_key.pub /tmp/extra-files/persist/etc/ssh/
chmod 600 /tmp/extra-files/persist/etc/ssh/ssh_host_ed25519_key
```
3. Run ```just hostname-deploy```.

The host keys for the target host will be copied during nixos-anywhere deployment, and my secrets will be able to be decrypted using the target host keys as needed.

### Configuring Secure Boot.

To enable Secure Boot for a host, there are a few manual steps that have to happen, focussed around generating encryption keys and enrolling them in to the UEFI firmware for Secure Boot.

1. Build the host without lanzaboote (just comment it out in the configuration.nix).
2. Run the following command to generate keys for the host:

```bash
sudo sbctl create-keys
```
3. Rebuild the host with lanzaboote added as an optional config (uncomment it from configuration.nix).
4. Reboot the host and enter the UEFI firmware configuration.
5. Enable Secure Boot and make sure it is in 'Setup Mode'. For my MSI motherboard, there isn't a specifc 'Setup Mode' option. Instead, I select 'Factory Keys' = 'disabled' and 'Secure Boot Mode' = 'Custom'. After rebooting and entering the UEFI firmware again, I can then go in to the newly added custom option and select 'Delete all UEFI vars'.
6. Reboot the host again.
7. Run the following command:

```bash
sudo sbctl verify
```
7. Ensure there are verified signatures. They will appear with a green tick.
8. Run the following command to enroll the keys:

```bash
# --microsoft ensures that Microsoft keys are enrolled by default so that we can dual boot with Windows if needed.
sudo sbctl enroll-keys --microsoft
```
9. Reboot the host again and enter the UEFI firmware.
10. Change the Secure Boot mode to 'Standard' - effectively bringing it out of Setup Mode.
11. Save changes and reboot the host.
12. Verify Secure Boot is enabled by running the following command:
```bash
sudo sbctl status
```
13. You should see that Secure Boot is listed as enabled (user).

## Hosts.

| System | Description | Type | OS | CPU | GPU |
|---|---|---|---|---|---|
| endgame | My personal desktop | Custom build | NixOS | AMD Ryzen 7800X3D | AMD 9070XT |
| flatmate | My mobile workstation | Surface Pro 7 | NixOS | Intel i7-1065G7 | Intel iGPU |
| spectre | My test VM | QEMU VM | NixOS | Host passthrough | OpenGL/3D accelerated |

I have a single user that I manage through Home Manager (tomwrw). You may add additional users or rename mine to inherit my existing settings - though you'll need to replace the age keys in '''.sops.yaml''' to your own, and re-create the '''secrets/secrets.yaml''' file with your own paths and secrets.

### File structure.

I use the following structure to organise my configurations.

```
.
├── flake.nix             # My flake. Entry point for system configs.
├── assets                # Stores additional items such as wallpapers and avatars.
│   ├── images            # Images used for this repo, such as logos.
│   └── wallpapers        # Wallpapers I used on my system that are used by my theme module.
├── home                  # Home folder that contains a folder for each Home Manager user.
│   └── tomwrw            # My primary user, managed by Home Manager.
│       ├── global        # Global Home Manager configs, all imported and applied to the user.
│       └── features      # Optional Home Manager configs, selectively imported per user.
├── modules               # Modules folder, containing a subfolder for both NixOS and Home Manager.
│   ├── home-manager      # Custom-written and sharable Home Manager modules.
│   └── nixos             # Custom-written and sharable NixOS modules.
├── hosts                 # NixOS configs, containing a subfolder for each host and a config folder.
│   ├── common            # NixOS config files for system configs.
│   │   ├── core          # Global system configs, to apply on every system.
│   │   ├── optional      # Optional system configs, selectively imported per host.
│   │   └── users         # Optional user settings to apply on selected systems with options.
│   └── nixos             # NixOS hosts managed by this repo.
│       └── endgame       # The configuration for my primary desktop system.
│       └── flatmate      # The configuration for my mobile device, a Surface Pro 7.
│       └── spectre       # The configuration for my test VM.
├── overlays              # Overlays folder containing any patches or overrides.
├── pkgs                  # Pkgs folder for storing any custom packaged apps.
```

## Community.

I learn by doing. None of this would be possible without the copious ammounts of developers and repos that share their content freely for others like me to disect and study. There are many, but to name a few - shout outs go to:

[ryan4yin](https://github.com/ryan4yin/) for their [awesome book](https://nixos-and-flakes.thiscute.world/) on NixOS (if you haven't started here, then give it a whirl - it really was great) and the [i3 Kickstarter repo](https://github.com/ryan4yin/nix-config/blob/i3-kickstarter/). Both excellent resources to help me understand the power of NixOS.

The majority of my config structure was heavily influenced by the awesome [Misterio77](https://github.com/Misterio77/). Not only did his [Nix Starter Configs](https://github.com/Misterio77/nix-starter-configs) help guide me early on, but his own [Nix Config](https://github.com/Misterio77/nix-config/tree/main) repo was a great inspiration on how to construct and model a modular Nix configuration.

#### And more inspiration...

- Nvim - https://github.com/Nvim (https://github.com/Nvim/snowfall)
- mtrsk - https://github.com/mtrsk (https://github.com/mtrsk/nixos-config)
- runarsf - https://github.com/runarsf (https://github.com/runarsf/dotfiles)
- librephoenix - https://github.com/librephoenix (https://github.com/librephoenix/nixos-config)
- frost-phoenix - https://github.com/Frost-Phoenix (https://github.com/Frost-Phoenix/nixos-config)