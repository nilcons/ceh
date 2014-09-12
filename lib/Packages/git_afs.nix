{
  packageOverrides = pkgs: {
    git_afs = builtins.trace (pkgs.git.patches) (derivation (pkgs.git.drvAttrs // { patches = pkgs.git.patches ++ [ "/opt/ceh/lib/Packages/git_afs.patch" ]; }));
#    tigervncNoWin = let
#      tigervnc = pkgs.tigervnc;
#      patch = ''
#        sed -i -e '/FL_KEYDOWN/a    if (Fl::event_key() == 65511) return 1;' vncviewer/Viewport.cxx
#        sed -i -e '/FL_KEYUP/a    if (Fl::event_key() == 65511) return 1;' vncviewer/Viewport.cxx
#      '' + tigervnc.patchPhase;
#    in derivation (tigervnc.drvAttrs // { patchPhase = patch; });
  };
}
