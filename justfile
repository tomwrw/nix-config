spectre-deploy:
    nix --extra-experimental-features 'nix-command flakes' run github:nix-community/nixos-anywhere -- --disko-mode disko --extra-files /tmp/extra-files --flake .#spectre --target-host nixos@spectre

spectre-rebuild:
    nixos-rebuild switch --flake .#spectre --target-host tomwrw@spectre --sudo

endgame-deploy:
    nix --extra-experimental-features 'nix-command flakes' run github:nix-community/nixos-anywhere -- --disko-mode disko --extra-files /tmp/extra-files --flake .#endgame --target-host nixos@endgame

endgame-rebuild:
    nixos-rebuild switch --flake .#endgame --target-host tomwrw@endgame --sudo

flatmate-deploy:
    nix --extra-experimental-features 'nix-command flakes' run github:nix-community/nixos-anywhere -- --disko-mode disko --extra-files /tmp/extra-files --flake .#flatmate --target-host nixos@flatmate

flatmate-rebuild:
    nixos-rebuild switch --flake .#flatmate --target-host tomwrw@flatmate --sudo