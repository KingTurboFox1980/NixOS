{ 

  inputs = { 

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; 

  }; 

 

 

  outputs = { self, nixpkgs, ... }: 

  let 

    system = "x86_64-linux"; # Adjust if your system architecture is different 

    pkgs = nixpkgs.legacyPackages.${system}; 

  in 

  { 

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem { 

      inherit system; 

      modules = [ 

        ./configuration.nix 

        ./hardware-configuration.nix 

        ({ config, pkgs, ... }: { 

          environment.systemPackages = with pkgs; [ 

            # Browsers & Networking 

            firefox 

            microsoft-edge 

            p3x-onenote 

            vivaldi 

            whatsapp-for-linux 

 

 

            # Development Tools 

            evolutionWithPlugins 

            geany 

            git 

            vim 

            vscode 

 

 

            # File Management 

            gvfs 

            kdePackages.dolphin 

            rclone 

            rclone-browser 

            xfce.thunar 

            xfce.thunar-archive-plugin 

            xfce.thunar-volman 

 

 

            # Multimedia & Theming 

            alsa-utils 

            brightnessctl 

            pywal 

            vlc 

            pkgs.xwallpaper 

 

 

            # UI Customization 

            arandr 

            arc-theme 

            pkgs.lxappearance-gtk2 

            material-cursors 

            rofi 

 

 

            # System Tools & Virtualization 

            pkgs.preload 

            bitwarden-desktop 

            bleachbit 

            dunst 

            gnome-calendar 

            gnome-disk-utility 

            lm_sensors 

            mate.engrampa 

            networkmanager 

            networkmanagerapplet 

            pulseaudioFull 

            swtpm 

            sysstat 

            virt-manager 

            virtiofsd 

            pkgs.xclip 

            xorg.xev 

 

 

            # Terminal Utilities 

            alacritty 

            btop 

            fastfetch 

            fzf 

            kitty 

            starship 

            zsh 

 

 

            # Other Utilities 

            qbittorrent 

            pkgs.vdhcoapp 

            wget 

            yt-dlp 

          ]; 

        }) 

      ]; 

    }; 

 

 

    devShells.default = pkgs.mkShell { 

      packages = with pkgs; [ 

        nix-tree 

        nixfmt 

      ]; 

    }; 

  }; 

} 

 