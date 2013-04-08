# Used by bin/coursera-dl

{
  packageOverrides = pkgs:
    {
      coursera-dl = pkgs.callPackage (
	{stdenv, fetchurl, makeWrapper, pythonPackages}: stdenv.mkDerivation {
	  name = "coursera-dl-20130407";

	  src = fetchurl {
	    url = "https://github.com/jplehmann/coursera/archive/c07d1ac40bc29b104976631559ec8fdce095952d.tar.gz";
	    sha256 = "92fc5b8eb8be9c8b30547ac798e34211accfc43f96e36e2fde5aa5f4dcd4fabc";
	  };

	buildInputs = [ makeWrapper pythonPackages.python pythonPackages.wrapPython pythonPackages.beautifulsoup ];

	installPhase = ''
          find
          cat requirements.txt
          ensureDir $out/bin/.wrapped
          cp -av coursera/coursera_dl.py $out/bin/.wrapped/coursera-dl
          makeWrapper ${pythonPackages.python}/bin/python $out/bin/coursera-dl \
            --prefix PYTHONPATH : $PYTHONPATH \
            --add-flags "$out/bin/.wrapped/coursera-dl"
        '';
	}) { };
    };
}
