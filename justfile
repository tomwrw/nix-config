cachyos-cache := "--option extra-substituters 'https://attic.xuyh0120.win/lantian' --option extra-trusted-public-keys 'lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc='"

spectre-deploy:
    nix --extra-experimental-features 'nix-command flakes' run github:nix-community/nixos-anywhere -- --disko-mode disko --flake .#spectre --target-host nixos@spectre {{ cachyos-cache }}

spectre-build:
    nixos-rebuild build --flake .#spectre {{ cachyos-cache }}

spectre-rebuild:
    nixos-rebuild switch --flake .#spectre --target-host tomwrw@spectre --ask-sudo-password {{ cachyos-cache }}

endgame-deploy:
    nix --extra-experimental-features 'nix-command flakes' run github:nix-community/nixos-anywhere -- --disko-mode disko --extra-files /tmp/extra-files --flake .#endgame --target-host nixos@endgame

endgame-rebuild:
    nixos-rebuild switch --flake .#endgame --target-host tomwrw@endgame --ask-sudo-password {{ cachyos-cache }}

flatmate-deploy:
    nix --extra-experimental-features 'nix-command flakes' run github:nix-community/nixos-anywhere -- --disko-mode disko --extra-files /tmp/extra-files --flake .#flatmate --target-host nixos@flatmate

flatmate-rebuild:
    nixos-rebuild switch --flake .#flatmate --target-host tomwrw@flatmate --ask-sudo-password {{ cachyos-cache }}
