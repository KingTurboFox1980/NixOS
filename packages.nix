{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Hyprland & Dependencies
    hyprland waybar xdg-utils xdg-desktop-portal-hyprland mako dunst wlogout
    swaylock-effects waypaper hyprshade hyprpaper wofi hyprlock hypridle hyprpicker
    grim slurp wl-clipboard nwg-look libsForQt5.qt5ct qt6ct pkgs.swww pkgs.rofi

    # Browsers & Networking
    firefox p3x-onenote whatsapp-for-linux networkmanager nm-tray

    # Development Tools
    evolutionWithPlugins geany git neovim vim vscode

    # File Management
    samba gvfs kdePackages.dolphin rclone rclone-browser xfce.thunar
    xfce.thunar-archive-plugin xfce.thunar-volman

    # Multimedia & Theming
    alsa-utils brightnessctl pywal vlc xwallpaper volumeicon blueberry nomacs nitrogen

    # UI Customization
    arandr arc-theme catppuccin-gtk dracula-theme gnome-tweaks material-cursors
    picom lxappearance-gtk2

    # Polkit
    libsForQt5.polkit-kde-agent

    # System Tools & Virtualization
    preload mission-center sxhkd asusctl bitwarden-desktop bleachbit conky lm_sensors
    gnome-calendar gnome-disk-utility mate.engrampa networkmanager networkmanagerapplet
    polkit_gnome pulseaudioFull swtpm sysstat virt-manager virtiofsd
    xclip xfce.xfce4-power-manager xorg.xev

    # Terminal Utilities
    alacritty btop fastfetch fzf kitty starship zsh

    # Flatpak Support
    flatpak

    # Other Utilities
    copyq qbittorrent wget yt-dlp galculator gammastep
  ];

  fonts.packages = with pkgs; [
    corefonts vistafonts inconsolata terminus_font proggyfonts dejavu_fonts font-awesome
    source-code-pro source-sans-pro source-serif-pro noto-fonts-emoji openmoji-color
    twemoji-color-font udev-gothic-nf texlivePackages.inconsolata-nerd-font
  ];
}
