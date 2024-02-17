# nix-templates
Basic templates for Nix, as well as instructions for installing Nix on my various systems.

# Installing on WSL for Windows 11
1. Install using [Determinate System's installer](https://zero-to-nix.com/start/install):  
   `curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install linux --init none`
3. Add one of [Nix's official stable channels](https://nixos.wiki/wiki/Nix_channels):  
   `nix-channel --add nix-channel --add https://nixos.org/channels/nixos-23.11`
4. Install [Home Manager](https://nix-community.github.io/home-manager/index.xhtml#sec-install-standalone) for user package management:  
   ```
   sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz home-manager
   sudo nix-channel --update
   ```
