# Based on https://github.com/NixOS/nixpkgs/blob/a790cc526b488cf5d9966e9a45d2f4d2a92963a5/pkgs/applications/editors/emacs/elisp-packages/manual-packages/lsp-bridge/default.nix
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
