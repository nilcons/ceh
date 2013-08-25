# Used by bin/coursera-dl

{
  packageOverrides = pkgs:
    {
      coursera-dl = pkgs.callPackage (
        {stdenv, fetchurl, makeWrapper, pythonPackages}: stdenv.mkDerivation {
          name = "coursera-dl-20130825";

          src = fetchurl {
            url = "https://github.com/jplehmann/coursera/archive/01cdfdecb008ce410195148c888439b65f1fe142.tar.gz";
            sha256 = "0vpwwj7whpgkirx39xrwz1k15b0k17qxbngzg599xzmql9fvqi3j";
          };

        buildInputs = [ makeWrapper pythonPackages.python pythonPackages.wrapPython pythonPackages.beautifulsoup4 pythonPackages.requests pythonPackages.six pythonPackages.html5lib ];

        installPhase = ''
          find
          cat requirements.txt
          ensureDir $out/bin/.wrapped
          cp -av coursera/* $out/bin/.wrapped
          ( cd $out/bin/.wrapped ; find -type f -exec sed -i 's/^from \./from /' {} \; )
          ( cd $out/bin/.wrapped ; find -type f -exec sed -i "s/ROOT, '_cache/os.getenv('HOME'), '.courseradl_cache/" {} \; )
          makeWrapper ${pythonPackages.python}/bin/python $out/bin/coursera-dl \
            --prefix PYTHONPATH : $PYTHONPATH \
            --add-flags "$out/bin/.wrapped/coursera_dl.py"
        '';
        }) { };
    };
}
