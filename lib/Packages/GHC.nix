# Used by ghc and co.

{
    packageOverrides = self : rec {
        cehGHC = self.haskellPackages_ghc763_profiling.ghcWithPackages (self : [
            # Selected from Haskell Platform:
            self.attoparsec
            self.fgl
            self.haskellSrc
            self.hashable
            self.html
            self.HTTP
            self.HUnit
            self.mtl
            self.network
            self.parallel
            self.parsec
            self.QuickCheck
            self.random
            self.regexBase
            self.regexCompat
            self.regexPosix
            self.split
            self.stm
            self.syb
            self.text
            self.transformers
            self.unorderedContainers
            self.vector
            self.xhtml
            self.zlib
            self.cabalInstall
            self.alex
            self.haddock
            self.happy
            self.primitive

            # command line tools
            self.hlint
            self.hoogle

            # Selected by CEH
            self.bytedump
            self.cabal2nix
            self.ChartGtk
            self.colour
            self.conduit
            self.cryptoApi
            self.cryptohash
            self.curl
            self.dataAccessor
            self.dataAccessorTemplate
            self.dataDefault
            self.deepseqTh
            self.digest
            self.Glob
            self.gtk
            self.haskellSrcExts
            self.hmatrix
            self.hflags
            self.hit
            self.hslogger
            self.HsOpenSSL
            self.lens
            self.MissingH
            self.monadLoops
            self.networkConduit
            self.networkProtocolXmpp
            self.pipes
            self.prettyShow
            self.randomFu
            self.regexTdfa
            self.templateDefault
            self.utf8String
            self.utilityHt
            self.vectorThUnbox
            self.zipArchive
            self.X11
            self.xtest
        ]);
    };
}
