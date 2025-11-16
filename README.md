#  Project: 

## Super Simple NixOS config for Hyprland with USWM

## This configuration was taken directly from `tony,btw` YouTube video 

### Hyprland: 
- UWSM enabled
- Autoloin 
- Simple flake 
- Simple Home Manager 
- Simple waybar


###  `Flake.nix`
```nix

{
  description = "Hyprland on Nixos";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    nixosConfigurations.hyprland-btw = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.dwilliams = import ./home.nix;
            backupFileExtension = "backup";
          };
        }
      ];
    };
  };
}
```

###  `home.nix`
```nix

{ config, pkgs, ... }:

{
  home.username = "dwilliams";
  home.homeDirectory = "/home/dwilliams";
  home.stateVersion = "25.11";
  programs = {
     neovim = {
        enable = true;
        defaultEditor = true;
        };
     bash = {
       enable = true;
       shellAliases = {
         ll = "eza -la --group-dirs-first --icons";
         v = "nvim";
         rebuild = "sudo nixos-rebuild switch --flake ~/tony-nixos/";
         update  = "nix flake update --flake ~/tony-nixos && sudo nixos-rebuild switch --flake ~/tony-nixos/";
    };

    profileExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        exec uwsm start -S hyprland-uwsm.desktop
      fi
    '';

    # The block below is for commands that should run every time a terminal starts.
    initExtra = ''
      # Source the personal file for all interactive shell sessions
      if [ -f ~/.bashrc-personal ]; then
        source ~/.bashrc-personal
      fi
    '';

  };
 };
    home.file.".config/hypr".source = ./config/hypr;
    home.file.".config/waybar".source = ./config/waybar;
    home.file.".config/foot".source = ./config/foot;
    home.file.".bashrc-personal".source = ./config/.bashrc-personal;
}
```


