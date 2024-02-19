{ pkgs }:

pkgs.mkShell {
  name = "nix development shell";

  packages = with pkgs; 
    let vscodeWithExtensions =
      vscode-with-extensions.override {
        vscodeExtensions = with vscode-extensions; [
          bbenoist.nix
          vscodevim.vim
        ];
      };
    in
      [ 
        vscodeWithExtensions 
      ];
}
