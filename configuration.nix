# Run this command to remake NixOS after editing this config 

# sudo nixos-rebuild switch 

# To update channels 
# nix-channel --update nixos 

# sudo nixos-rebuild switch --upgrade

 
{ config, pkgs, lib, ... }: 

let 

  nix-software-center = import (pkgs.fetchFromGitHub { 

    owner = "snowfallorg"; 

    repo = "nix-software-center"; 

    rev = "0.1.2"; 

    sha256 = "xiqF1mP8wFubdsAQ1BmfjzCgOD3YZf7EGWl9i69FTls="; 

  }) {}; 

in 

  

{ 

  imports = 

    [ 

      ./hardware-configuration.nix 

    ]; 

  

  # Bootloader setup 

  boot.loader.systemd-boot.enable = true; 

  boot.loader.efi.canTouchEfiVariables = true; 

  

  # Networking 

  networking.hostName = "nixos"; 

  networking.networkmanager.enable = true; 

  

  # Localization 

  time.timeZone = "America/Toronto"; 

  i18n.defaultLocale = "en_CA.UTF-8"; 

  

  # Display server and desktop environment 

  services.xserver.enable = true; 

  services.xserver.videoDrivers = [ "modesetting" ]; 

  services.displayManager.sddm.enable = true; 

  services.desktopManager.plasma6.enable = true; 

  systemd.services.dlm.wantedBy = [ "multi-user.target" ];

  

  # Virtualization 

  virtualisation.libvirtd.enable = true; 

  

  # Audio configuration 

  hardware.pulseaudio.enable = false; 

  services.pipewire = { 

    enable = true; 

    alsa.enable = true; 

    alsa.support32Bit = true; 

    pulse.enable = true; 

  }; 

  

  # Printing service 

  services.printing.enable = true; 

  

  # System packages 

  environment.systemPackages = with pkgs; [ 
    arandr 
    btop  
    fastfetch  
    firefox
    fzf 
    geany 
    git 
    kitty 
    libvirt 
    linuxKernel.packages.linux_zen.evdi 
    material-cursors 
    microsoft-edge
    nix-software-center 
    nitrogen 
    p3x-onenote 
    pkgs.evolutionWithPlugins 
    pkgs.gnome-calendar 
    pkgs.gnome-disk-utility
    plex 
    qbittorrent 
    qemu 
    rofi 
    rclone 
    rclone-browser 
    starship 
    virt-manager 
    vim 
    vivaldi
    vscode 
    wget 
    xfce.thunar 
    zsh
  ]; 

  

  # Define a user account. Don't forget to set a password with ‘passwd’.  
 users.users.j3ll0 = {  
   isNormalUser = true;  
   description = "Angelo";  
   extraGroups = [ "networkmanager" "wheel" "libvirtd" ];  
   packages = with pkgs; [  
     kdePackages.kate  
   #  thunderbird  
   ];  
 }; 
 

  nix.settings.experimental-features = [ "nix-command" ];

  # Allow unfree packages 

  nixpkgs.config.allowUnfree = true; 

  

  # System state version 

  system.stateVersion = "24.11"; 

} 
