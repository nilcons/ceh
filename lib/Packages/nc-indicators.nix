# Used by bin/nc-indicators.

{
  packageOverrides = pkgs: {
    nc-indicators = pkgs.haskellPackages_ghc763_profiling.callPackage (
      { cabal, attoparsec, gtk, hflags, lens, pipes, stm }:

      cabal.mkDerivation (args: {
        pname = "nc-indicators";
        version = "0.1";
        sha256 = "19amwfcbwfxcj0gr7w0vgxl427l43q3l2s3n3zsxhqwkfblxmfy5";
        isLibrary = false;
        isExecutable = true;
        buildDepends = [ attoparsec gtk hflags lens pipes stm ];
        meta = {
          homepage = "https://github.com/nilcons/nc-indicators";
          description = "CPU load and memory usage indicators for i3bar";
          license = args.stdenv.lib.licenses.asl20;
          platforms = args.ghc.meta.platforms;
        };
      })
    ) {};
  };
}
