{ pkgs }:

pkgs.mkShell {
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
}
