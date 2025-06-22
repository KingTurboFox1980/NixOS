{ config, pkgs, ... }:

{
  services = {
    flatpak.enable = true;
    udisks2.enable = true;
    gvfs.enable = true;
    asusd.enable = true;
  };

  security.polkit.enable = true;

  programs.virt-manager.enable = true;

  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };
}
