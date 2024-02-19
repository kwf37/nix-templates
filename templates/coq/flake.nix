{
  description = "Template Coq shell";

  # Flake inputs
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/23.11";
  };

  # Flake outputs
  outputs = { self, nixpkgs }:
    let
      # Systems supported
      allSystems = [
        "x86_64-linux" # 64-bit Intel/AMD Linux
        "aarch64-linux" # 64-bit ARM Linux
        "x86_64-darwin" # 64-bit Intel macOS
        "aarch64-darwin" # 64-bit ARM macOS
      ];

      # Helper to provide system-specific attributes
      forAllSystems = f: nixpkgs.lib.genAttrs allSystems (system: f {
        pkgs = import nixpkgs { 
            inherit system; 
            config.allowUnfree = true;
        };
      });
    in
    {
      # Development environment output
      devShells = forAllSystems ({ pkgs }: 
      
      {
        default = pkgs.mkShell {
          name = "Coq development shell, for formal verification";

          packages = with pkgs; 
              let vscodeWithExtensions =
              vscode-with-extensions.override {
                  vscodeExtensions = with vscode-extensions; [
                  bbenoist.nix
                  vscodevim.vim
                  maximedenes.vscoq
                  ];
              };
              in
              [ 
                vscodeWithExtensions 
                opam
                coq
              ];
          };
      });
    };
}