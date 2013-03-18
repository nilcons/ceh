# Used by bin/coursera-dl

{
  packageOverrides = pkgs:
    {
      coursera-dl = pkgs.callPackage (
	{stdenv, fetchurl, makeWrapper, pythonPackages}: stdenv.mkDerivation {
	  name = "coursera-dl-20130318";

	  src = fetchurl {
	    url = "https://github.com/jplehmann/coursera/archive/f7d76301180ffa60986b608f9f27efd6985935ae.tar.gz";
	    sha256 = "18546j6xb7jdca0nlgxffjlqr49bn0q7ypvk7lc94w3w4yjpyi11";
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
