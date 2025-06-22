#!/usr/bin/env bash

# NixOS Maintenance & Update Menu 
flake_path="/etc/nixos"
script_path="$0"

clear
echo "🩺 NixOS Maintenance Menu"
echo "Select an action:"
echo
echo " 1) 🧹  System Cleanup & Optimization"
echo " 2) 🚀  Standard NixOS Flakes Rebuild"
echo " 3) 🧪  Test NixOS Flakes Rebuild"
echo " 4) ℹ️  List NixOS Generations"
echo " 5) 🗑️  Delete a Specific Generation"
echo " 6) 🗑️  Delete All Old Generations"
echo " 7) 🧹  Clean Up Boot Menu"
echo " 8) ⬆️  Update Software Channel & Switch"
echo " 9) 🔄  Update Flakes"
echo "10) 📦  Update Flatpak Apps"
echo "11) 📅  View Auto-Upgrade Timer Status"
echo "12) 🩺  Check Auto-Upgrade Service Health"
echo "13) 📝  Edit This Menu Script"
echo "14) 🚪  Exit"
echo
read -rp "Enter your choice: " choice

case $choice in
  1)
    echo "🧹 Running cleanup..."
    sudo nix-collect-garbage
    sudo nix store optimise
    sudo nix-collect-garbage -d
    nix profile wipe-history --older-than 100d
    echo "✅ Cleanup complete!"
    ;;

  2)
    echo "🚀 Rebuilding NixOS with flakes..."
    cd "$flake_path" || exit
    sudo nixos-rebuild switch --flake .
    ;;

  3)
    echo "🧪 Performing test rebuild..."
    cd "$flake_path" || exit
    if sudo nixos-rebuild build --flake .; then
      echo "✅ Build passed."
      read -rp "Proceed with switch? (Y/n): " proceed
      if [[ "${proceed^^}" == "Y" || -z "$proceed" ]]; then
        sudo nixos-rebuild switch --flake .
      else
        echo "⏩ Skipping switch."
      fi
    else
      echo "❌ Build failed. Please check errors."
    fi
    ;;

  4)
    echo "ℹ️ Listing generations..."
    sudo nix-env -p /nix/var/nix/profiles/system --list-generations
    ;;

  5)
    read -rp "Enter generation to delete: " gen
    echo "🗑️ Deleting generation $gen..."
    sudo nix-env -p /nix/var/nix/profiles/system --delete-generations "$gen"
    cd "$flake_path" && sudo nixos-rebuild boot
    ;;

  6)
    echo "🗑️ Deleting all old generations..."
    sudo nix-env -p /nix/var/nix/profiles/system --delete-generations old
    cd "$flake_path" && sudo nixos-rebuild boot
    ;;

  7)
    echo "🧹 Rebuilding boot menu..."
    cd "$flake_path" && sudo nixos-rebuild boot
    ;;

  8)
    echo "⬆️ Updating channel and switching system..."
    nix-channel --update nixos
    cd "$flake_path" && sudo nixos-rebuild switch --upgrade
    ;;

  9)
    echo "🔄 Updating flake..."
    cd "$flake_path" && sudo nix flake update
    echo "✅ Flake update complete."
    ;;

  10)
    echo "📦 Updating Flatpak apps..."
    flatpak update
    echo "✅ Flatpaks updated!"
    ;;

  11)
    echo "📅 Auto-upgrade timer status:"
    systemctl status nixos-upgrade.timer
    ;;

  12)
    echo "🩺 Auto-upgrade service health:"
    systemctl status nixos-upgrade.service
    ;;

  13)
    echo "📝 Opening this script..."
    kitty sudo nvim "$script_path"
    ;;

  14)
    echo "🚪 Goodbye!"
    exit 0
    ;;

  *)
    echo "⚠️ Invalid selection."
    ;;
esac

echo
read -rp "Press Enter to exit."

