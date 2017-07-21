{
  packageOverrides = pkgs: {
    rxvt_unicode = let
      urxvt = pkgs.rxvt_unicode;
      patch = ''
        sed -i -e '/PrivMode_mouse_report/s,.*,#define PrivMode_mouse_report 0,' src/rxvt.h
      '' + (urxvt.patchPhase or "");
    in derivation (urxvt.drvAttrs // { patchPhase = patch; });
  };
}
