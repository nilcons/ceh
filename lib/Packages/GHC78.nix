# Used by ghc and co.

{
  packageOverrides = pkgs: {
    cehGHC78 = pkgs.haskell.packages_ghc782.ghcWithPackagesOld (hs:
      [
        # no packages on hydra for 7.8 currently :(
      ]
    );
  };
}
