# Based on https://github.com/NixOS/nixpkgs/blob/af21d41260846fb9c9840a75e310e56dfe97d6a3/pkgs/applications/editors/emacs/elisp-packages/melpa-packages.nix#L483
{
  emacs,
  pkgs,
  ...
}: old: {
  nativeBuildInputs = [
    pkgs.cmake
    pkgs.gcc
  ];
  buildInputs = old.buildInputs ++ [pkgs.libvterm-neovim];
  cmakeFlags = [
    "-DEMACS_SOURCE=${emacs.src}"
  ];
  preBuild = ''
    mkdir -p build
    cd build
    cmake ..
    make
    install -m444 -t . ../*.so
    install -m600 -t . ../*.el
    cp -r -t . ../etc
    rm -rf {CMake*,build,*.c,*.h,Makefile,*.cmake}
  '';
}
