# Based on
# https://github.com/nixos/nixpkgs/tree/2cb1420c66c8e634314ce0abf70680208177f5b4/pkgs/applications/editors/emacs/elisp-packages/melpa-packages.nix
{ pkgs, ... }:
old: {
  nativeBuildInputs = [ pkgs.gcc ];
  buildInputs = old.buildInputs ++ [ pkgs.librime ];
  preBuild = ''
    make lib CC=$CC MODULE_FILE_SUFFIX=${pkgs.stdenv.hostPlatform.extensions.sharedLibrary}
    rm *.c Makefile
    chmod 444 *.so
  '';
}
