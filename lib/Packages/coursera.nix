# Used by bin/coursera-dl

{
  packageOverrides = pkgs:
    {
      coursera-dl = pkgs.callPackage (
	{stdenv, fetchurl, makeWrapper, pythonPackages}: stdenv.mkDerivation {
	  name = "coursera-dl-20130527";

	  src = fetchurl {
	    url = "https://github.com/jplehmann/coursera/archive/300d77cf0a195cb796b982e421f780917dc89683.tar.gz";
	    sha256 = "0d7614a85a0f3e5870cf193658e3af1024f5fbb1b52b7946c8fe7da4169ae766";
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
