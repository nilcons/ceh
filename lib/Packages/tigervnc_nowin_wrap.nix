{
  packageOverrides = pkgs: {
    tigervncNoWin = pkgs.callPackage ./tigervnc_nowin.nix {
      fontDirectories = [ pkgs.xorg.fontadobe75dpi pkgs.xorg.fontmiscmisc
        pkgs.xorg.fontcursormisc pkgs.xorg.fontbhlucidatypewriter75dpi ];
      xorgserver = pkgs.xorg.xorgserver;
      fltk = pkgs.fltk13;
    };
  };
}
