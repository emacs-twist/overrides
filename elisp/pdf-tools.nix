{pkgs, ...}: old: {
  CXXFLAGS = "-std=c++17";

  nativeBuildInputs = [
    pkgs.autoconf
    pkgs.automake
    pkgs.pkg-config
    pkgs.removeReferencesTo
  ];

  buildInputs = old.buildInputs ++ [pkgs.libpng pkgs.zlib pkgs.poppler];

  preBuild = ''
    make server/epdfinfo
    cp server/epdfinfo .
    rm -r Makefile lisp server
  '';
}
