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
    in {
      devShells = forAllSystems ( { pkgs }:
        let nixShell = import ./devShells/nix.nix { inherit pkgs; }; in
        {
          nix = nixShell;
          coq = import ./devShells/coq.nix { inherit pkgs; };
          default = nixShell;
        }
      );
    };
}
