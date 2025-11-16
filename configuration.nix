{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "hyprland-btw"; 
  networking.networkmanager.enable = true;

   time.timeZone = "America/New_York";

   services.getty.autologinUser = "dwilliams";

   programs.hyprland = { 
      enable = true; 
      xwayland.enable = true; 
      withUWSM = true;
    };

  # Select internationalisation properties.
   i18n.defaultLocale = "en_US.UTF-8";

   services.pipewire = {
     enable = true;
     pulse.enable = true;
   };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.dwilliams = {
     isNormalUser = true;
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
       tree
     ];
   };

  programs = {
    firefox.enable = true;
    thunar.enable = true;
    };

   environment.systemPackages = with pkgs; [

    ## Hyprland specific 
     hyprpaper
     hyprshot
     hypridle
     hyprlock
     hyprpicker
     xdg-desktop-portal-hyprland
     
     
     # Hyprland Related 
     clipman
     grim
     slurp
     nwg-look
     nwg-dock-hyprland
     nwg-menu
     nwg-panel
     nwg-launchers
     rofi
     wofi 
     waybar
     waypaper


     atop
     bat 
     btop 
     clang
     curl
     eza
     fastfetch
     foot
     git
     gcc
     git
     gping
     google-chrome
     kitty
     lunarvim
     luarocks
     ncdu 
     onefetch
     pciutils
     ripgrep
     starship
     tmux
     ugrep
     vim
     wget
     yazi
     zig
     zoxide
   ];
        fonts = {
            packages = with pkgs; [
              dejavu_fonts
              fira-code
              fira-code-symbols
              font-awesome
              hackgen-nf-font
              ibm-plex
              inter
              jetbrains-mono
              material-icons
              maple-mono.NF
              minecraftia
              nerd-fonts.im-writing
              nerd-fonts.blex-mono
              noto-fonts
              noto-fonts-color-emoji
              noto-fonts-cjk-sans
              noto-fonts-cjk-serif
              noto-fonts-monochrome-emoji
              powerline-fonts
              roboto
              roboto-mono
              symbola
              terminus_font
            ];
          };


   nixpkgs.config.allowUnfree = true;
   nix.settings.experimental-features = [ "nix-command" "flakes" ];
   security.sudo.wheelNeedsPassword = false;

   programs.mtr.enable = true;
   programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
   };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;


  system.stateVersion = "25.11"; # Did you read the comment?

}

