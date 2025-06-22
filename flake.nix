{
  description = "💫 NixOS + Hyprland Flake (Enhanced by j3ll0)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, hyprland, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ hyprland.overlays.default ];
        };
      in {
        packages.default = pkgs.hello;

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [ git hyprland ];
          shellHook = ''
            echo "🦇 Hyprland devShell active. Hack the planet."
          '';
        };

        formatter = pkgs.nixpkgs-fmt;
      }
    ) // {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
            hyprland.nixosModules.default
          ];
        };
      };

      nixosModules = {
        hyprland = hyprland.nixosModules.default;
      };
    };
}

