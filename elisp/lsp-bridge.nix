# Based on https://github.com/akirak/nixpkgs/blob/tree-sitter-mermaid/pkgs/applications/editors/emacs/elisp-packages/manual-packages/lsp-bridge/default.nix
{pkgs, ...}: _old: {
  patches = [
    (pkgs.substituteAll {
      src = ./lsp-bridge-python.patch;
      python3 =
        (pkgs.python3.withPackages (ps:
          with ps; [
            epc
            orjson
            sexpdata
            six
          ]))
        .interpreter;
    })
  ];
}
