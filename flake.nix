{
  description = "Nix development environment templates";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [
        "x86_64-linux" # 64-bit Intel/AMD Linux
        "aarch64-linux" # 64-bit ARM Linux
        "x86_64-darwin" # 64-bit Intel macOS
        "aarch64-darwin" # 64-bit ARM macOS
      ];

      forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
        pkgs = import nixpkgs { 
          inherit system; 
          config.allowUnfree = true;
        };
      });

      devShellFromTemplate = { templateName, system }: 
        let 
          flake = import ./templates/${templateName}/flake.nix;
          output = flake.outputs { self = self; nixpkgs = nixpkgs; };
        in
          output.devShells.${system}.default;
    in {
      devShells = forAllSystems ({ pkgs }:
        let nixShell = devShellFromTemplate { templateName = "nix"; system = pkgs.system; }; in
        {
          nix = nixShell;
          frontend = devShellFromTemplate { templateName = "frontend"; system = pkgs.system; };
          coq = devShellFromTemplate { templateName = "coq"; system = pkgs.system; };
          default = nixShell;
        }
      );

      templates = 
        {
          nix = {
            path = ./templates/nix;
            description = "Nix dev environment template";
          };

          frontend = {
            path = ./templates/frontend;
            description = "Frontend dev environment template";
          };
        
          coq = {
            path = ./templates/coq;
            description = "Coq dev environment template";
          };
        };
    };
}
