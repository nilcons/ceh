# Used by bin/coursera-dl

{
  packageOverrides = pkgs:
    {
      coursera-dl = pkgs.callPackage (
        {stdenv, fetchurl, makeWrapper, pythonPackages}: stdenv.mkDerivation {
          name = "coursera-dl-20140529";

          src = fetchurl {
            url = "https://github.com/coursera-dl/coursera/archive/031b7835b26a7347c6ac4b88dea781de82789c01.tar.gz";
            sha256 = "11zxj4lg75sygswc01pc124sr3g9y93y9k8ccqph09nbgc9hik6m";
          };

          buildInputs = [ makeWrapper pythonPackages.python
            pythonPackages.wrapPython pythonPackages.beautifulsoup4
            pythonPackages.requests pythonPackages.six
            pythonPackages.html5lib ];

          patchPhase = ''
            sed -i "s|PATH_CACHE = os\.path\.join(.*\$|PATH_CACHE = '/opt/ceh/home/.courseradl_cache'|" coursera/define.py
          '';

          installPhase = ''
            mkdir -p $out/bin/.wrapped
            cp -av coursera-dl $out/bin/.wrapped/coursera-dl
            mkdir -p $out/lib/${pythonPackages.python.libPrefix}/site-packages/coursera
            cp -av coursera/*.py $out/lib/${pythonPackages.python.libPrefix}/site-packages/coursera
            makeWrapper ${pythonPackages.python}/bin/python $out/bin/coursera-dl \
              --prefix PYTHONPATH : $PYTHONPATH \
              --suffix PYTHONPATH : $out/lib/${pythonPackages.python.libPrefix}/site-packages \
              --add-flags "$out/bin/.wrapped/coursera-dl"
          '';
          }) { };
    };
}
