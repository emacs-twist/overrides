{pkgs, ...}: old: {
  buildInputs = old.buildInputs ++ [pkgs.git];
}
