# Based on https://github.com/akirak/nixpkgs/blob/tree-sitter-mermaid/pkgs/applications/editors/emacs/elisp-packages/elpa-packages.nix#L120
# originally written by Damien Cassou.
{pkgs, ...}: old: let
  moduleSuffix = pkgs.stdenv.targetPlatform.extensions.sharedLibrary;
in {
  nativeBuildInputs = [
    pkgs.gcc
    pkgs.pkg-config
  ];

  buildInputs = old.buildInputs ++ [pkgs.enchant2];

  preBuild = ''
    NIX_CFLAGS_COMPILE="$($PKG_CONFIG --cflags enchant-2) $NIX_CFLAGS_COMPILE"
    $CC -I. -O2 -fPIC -shared -o jinx-mod${moduleSuffix} jinx-mod.c -lenchant-2
    rm *.c *.h
  '';
}
