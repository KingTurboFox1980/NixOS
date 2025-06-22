{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
    ./gui.nix
    ./services.nix
    ./update.nix
  ];

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelParams = [ "mitigations=off" ];
  boot.kernel.sysctl."vm.dirty_ratio" = 20;

  zramSwap.enable = true;
  programs.xfconf.enable = true;

  fileSystems."/mnt/downloads" = {
    device = "/dev/disk/by-uuid/4681ad39-ed76-4fe7-ab87-d3a03816a8a1";
    fsType = "ext4";
    options = [ "defaults" ];
  };
  fileSystems."/tmp" = {
    device = "tmpfs";
    fsType = "tmpfs";
    options = [ "size=2G" "mode=1777" ];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  users.users.j3ll0 = {
    isNormalUser = true;
    description = "Angelo";
    extraGroups = [ "wheel" "networkmanager" "libvirtd" ];
    packages = with pkgs; [ kdePackages.kate ];
  };

  system.stateVersion = "25.05";
}
