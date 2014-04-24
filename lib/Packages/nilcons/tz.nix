tzdata:
{ cabal, binary, bindingsPosix, deepseq, HUnit, QuickCheck
, testFramework, testFrameworkHunit, testFrameworkQuickcheck2
, testFrameworkTh, time, vector
}:

cabal.mkDerivation (self: {
  pname = "tz";
  version = "0.0.0.5";
  sha256 = "03s5vs08dj3r7rq78ncya6x6dazvr93gfylyynwybpai09l2y89v";
  buildDepends = [ binary deepseq time tzdata vector ];
  # Because there is no TZDIR envvar during the build the tests have
  # no chance to succeed.
  # TODO(klao): add a sanity check to the tests instead.
  doCheck = false;
  testDepends = [
    bindingsPosix HUnit QuickCheck testFramework testFrameworkHunit
    testFrameworkQuickcheck2 testFrameworkTh time tzdata
  ];
  meta = {
    homepage = "https://github.com/nilcons/haskell-tz";
    description = "Efficient time zone handling";
    license = self.stdenv.lib.licenses.asl20;
    platforms = self.ghc.meta.platforms;
  };
})
