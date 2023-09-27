/*
Function that should be passed to overrideScope' under an emacsTwist scope.
*/
# Both self and super are instances of emacsTwist scope.
self: super: {
  elispPackages = super.elispPackages.overrideScope' (
    _eself: esuper: let
      inherit (super) lib;

      args =
        # Select only certain attributes from the parent scope to prevent
        # contributors from making mistakes.
        lib.getAttrs
        [
          "emacs"
          "lib"
          "pkgs"
        ]
        super;
    in
      lib.genAttrs
      (lib.intersectLists
        (builtins.attrNames esuper)
        (lib.pipe (builtins.readDir ./.) [
          (lib.filterAttrs (name: type: type == "regular" && name != "default.nix"))
          builtins.attrNames
          (builtins.map (lib.removeSuffix ".nix"))
        ]))
      (
        ename:
          esuper.${ename}.overrideAttrs (import (./. + "/${ename}.nix") args)
      )
  );
}
