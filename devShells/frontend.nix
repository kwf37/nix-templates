{ pkgs }:

pkgs.mkShell {
  name = "Frontend development shell";

  packages = with pkgs; 
    let vscodeWithExtensions =
      vscode-with-extensions.override {
        vscodeExtensions = with vscode-extensions; [
          bbenoist.nix
          vscodevim.vim
          dbaeumer.vscode-eslint
          esbenp.prettier-vscode
          formulahendry.auto-rename-tag
          yzhang.markdown-all-in-one
        ];
      };
    in
      [ 
        vscodeWithExtensions 
        nodejs-18_x
        nodePackages.pnpm
      ];
}
