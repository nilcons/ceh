# Used by ghc and co.

{
    packageOverrides = pkgs : {
	cabal.libraryProfiling = true;
	hsEnv = pkgs.haskellPackages.ghcWithPackages (self : [
            pkgs.haskellPlatform
	    pkgs.haskellPackages.text
	]);
    };
}
