# Used by ghc and co.

{
    packageOverrides = pkgs : {
        cabal.libraryProfiling = true;
        hsEnv = pkgs.haskellPackages.ghcWithPackages (self : [
            pkgs.haskellPackages_ghc763_profiling.haskellPlatform
            pkgs.haskellPackages_ghc763_profiling.text
            pkgs.haskellPackages_ghc763_profiling.lens
        ]);
    };
}
