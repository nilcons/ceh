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

          buildInputs = [ makeWrapper pythonPackages.python
            pythonPackages.wrapPython pythonPackages.beautifulsoup4
            pythonPackages.requests pythonPackages.six
            pythonPackages.html5lib ];

          patchPhase = ''
            sed -i "s|PATH_CACHE = os\.path\.join(ROOT, '_cache')|PATH_CACHE = '/opt/ceh/home/.courseradl_cache/'|" coursera/define.py
          '';

          installPhase = ''
            ensureDir $out/bin/.wrapped
            cp -av coursera-dl $out/bin/.wrapped/coursera-dl
            ensureDir $out/lib/${pythonPackages.python.libPrefix}/site-packages/coursera
            cp -av coursera/*.py $out/lib/${pythonPackages.python.libPrefix}/site-packages/coursera
            makeWrapper ${pythonPackages.python}/bin/python $out/bin/coursera-dl \
              --prefix PYTHONPATH : $PYTHONPATH \
              --suffix PYTHONPATH : $out/lib/${pythonPackages.python.libPrefix}/site-packages \
              --add-flags "$out/bin/.wrapped/coursera-dl"
          '';
          }) { };
    };
}
