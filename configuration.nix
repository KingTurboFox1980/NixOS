# NixOS Configuration File 

{ config, lib, pkgs, ... }: 

 

 

let 

  vivaldi = pkgs.vivaldi.overrideAttrs (oldAttrs: { 

    dontWrapQtApps = false; 

    dontPatchELF = true; 

    nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [pkgs.kdePackages.wrapQtAppsHook]; 

  }); 

in 

 

 

{ 

  imports = [ 

    ./hardware-configuration.nix 

  ]; 

 

 

  # Bootloader Configuration 

  boot.loader.systemd-boot.enable = true; 

  boot.loader.efi.canTouchEfiVariables = true; 

 

 

  networking.hostName = "nixos"; 

  networking.networkmanager.enable = true; 

 

 

  # Time and Locale Settings 

  time.timeZone = "America/Toronto"; 

  i18n.defaultLocale = "en_CA.UTF-8"; 

 

 

  # Enable X11 and KDE Plasma 6 

  services.xserver.enable = true; 

  services.displayManager.sddm.enable = true; 

  services.desktopManager.plasma6.enable = true; 

 

 

  # Keyboard Layout 

  services.xserver.xkb = { 

    layout = "us"; 

    variant = ""; 

  }; 

 

 

  # Printing & File Sharing 

  services = { 

    printing.enable = true; 

    gvfs.enable = true; 

    udisks2.enable = true; 

    samba.enable = true; 

    nfs.server.enable = true; 

    preload.enable = true; 

 

 

    pipewire = { 

      enable = true; 

      alsa = { enable = true; support32Bit = true; }; 

      pulse.enable = true; 

    }; 

 

 

    gnome.gnome-keyring.enable = true; 

  }; 

 

 

  # User Account Configuration 

  users.users.j3ll0 = { 

    isNormalUser = true; 

    description = "Angelo"; 

    extraGroups = [ "networkmanager" "wheel" "libvirtd" ]; 

    packages = with pkgs; [ # Keep any user-specific packages here 

      kdePackages.kate 

    ]; 

  }; 

 

 

  # Enable virtualization 

  virtualisation.libvirtd.enable = true; 

 

 

  # Performance Optimizations 

  zramSwap.enable = true; 

  programs.xfconf.enable = true; 

  boot.kernel.sysctl."vm.dirty_ratio" = 20; 

 

 

  fileSystems."/tmp" = { 

    device = "tmpfs"; 

    fsType = "tmpfs"; 

    options = [ "size=2G" "mode=1777" ]; 

  }; 

 

 

  boot.kernelParams = [ "mitigations=off" ]; 

 

 

  # Scheduled System Upgrades 

  system.autoUpgrade = { 

    enable = true; 

    flags = [ "--upgrade" "-L" ]; 

    dates = "Sun *-*-* 05:00:00"; 

    randomizedDelaySec = "30min"; 

    persistent = true; 

  }; 

 

 

  nix.settings.cores = 12; 

  nix.gc.automatic = true; 

  nix.gc.dates = "Sun *-*-* 05:00:00"; 

 

 

  systemd = { 

    services.autoRebuild = { 

      enable = true; 

      description = "Auto-rebuild system after updates"; 

      serviceConfig = { 

        ExecStart = "${pkgs.bash}/bin/bash -c 'nix-channel --update && nixos-rebuild switch'"; 

      }; 

    }; 

    timers.autoRebuild = { 

      enable = true; 

      description = "Trigger auto-rebuild system"; 

      timerConfig = { 

        OnCalendar = "Sun *-*-* 05:00:00"; 

        Persistent = true; 

      }; 

      wantedBy = [ "timers.target" ]; 

    }; 

  }; 

 

 

  # Enable Unfree Packages (Keep this here or in the flake, either works) 

  nix.settings.experimental-features = [ "nix-command" "flakes"]; 

  nixpkgs.config.allowUnfree = true; 

 

 

  # System State Version 

  system.stateVersion = "24.11"; 

} 

 