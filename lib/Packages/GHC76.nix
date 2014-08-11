# Used by ghc and co.

{
  packageOverrides = pkgs: {
    cehGHC76 = pkgs.haskell.packages_ghc763.ghcWithPackagesOld (hs:
      [
        # no packages on hydra for 7.6 :(
      ]
    );
  };
}
