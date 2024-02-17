# nix-templates
Basic templates for Nix, as well as instructions for installing Nix on my various systems.

# Installing on WSL for Windows 11
1. Install using [Determinate System's installer](https://zero-to-nix.com/start/install):  
   `curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install`
4. Install [Home Manager](https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-standalone) for user package management:  
   ```
   nix run home-manager/release-23.11 -- init --switch
   ```
