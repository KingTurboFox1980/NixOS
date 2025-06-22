{ config, pkgs, ... }:

{
  services.xserver.enable = true;
  services.dbus.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.waybar.enable = true;
  programs.dconf.enable = true;

  services.gnome.gnome-keyring.enable = true;

  systemd.user.services.plasma-polkit-agent = {
    description = "Plasma Polkit Agent";
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.libsForQt5.polkit-kde-agent}/bin/plasma-polkit-agent";
      Restart = "on-failure";
      RestartSec = 1;
    };
  };

  hardware.enableAllFirmware = true;

  services.libinput.enable = true;  # Touchpad support
  services.power-profiles-daemon.enable = true;  # Laptop power tuning
}
