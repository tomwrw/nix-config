spectre-deploy:
    nix --extra-experimental-features 'nix-command flakes' run github:nix-community/nixos-anywhere -- --disko-mode disko --flake .#spectre --target-host nixos@spectre

spectre-rebuild:
    nixos-rebuild switch --flake .#spectre --target-host tomwrw@spectre --sudo

endgame-deploy:
    nix --extra-experimental-features 'nix-command flakes' run github:nix-community/nixos-anywhere -- --disko-mode disko --flake .#endgame --target-host nixos@endgame

endgame-rebuild:
    nixos-rebuild switch --flake .#endgame --target-host tomwrw@endgame --sudo