# update.nix
{ config, pkgs, ... }:

{
  system.autoUpgrade = {
    enable = true;
    flake = "/etc/nixos/#nixos";
    flags = [
      "--update-input" "nixpkgs"
      "--commit-lock-file"
      "-L"
    ];
    dates = "Sun *-*-* 05:00:00";
    randomizedDelaySec = "45min";
    persistent = true;
  };
}

