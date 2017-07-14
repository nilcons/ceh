# Used by bin/firefox.

{
  packageOverrides = pkgs: rec
    {
      emacs25-nogtk = pkgs.emacs25.override {
        withGTK2 = false;
        withGTK3 = false;
      };
    };
}
