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
            self.cabalInstall_1_18_0_1
            self.Cabal_1_18_1
            self.alex_3_1_0
            self.haddock
            self.happy_1_19_0
            self.primitive

            # command line tools
            self.hlint
            self.hoogle
            self.cabal2nix
            self.cabalGhci
            self.ghcMod
            self.ghcVis
            self.ghcHeapView

            # compilation tools
            self.c2hs
            self.hscolour

            # Selected by CEH
            self.async
            self.bindingsPosix
            self.bytedump
            self.unixBytestring
            self.ChartGtk
            self.colour
            self.conduit
            self.criterion
            self.cryptoApi
            self.cryptohash
            self.curl
            self.dataAccessor
            self.dataAccessorTemplate
            self.dataDefault
            self.dataMemocombinators
            self.deepseqTh
            self.digest
            self.elerea
            self.Glob
            self.gloss
            self.gtk
            self.haskellSrcExts
            self.HFuse
            self.hmatrix
            self.hflags
            self.hit
            self.hslogger
            self.HsOpenSSL
            self.hspec
            self.lens
            self.lensDatetime
            self.linear
            self.MissingH
            self.modularArithmetic
            self.monadLoops
            self.ncurses
            self.networkConduit
            self.networkProtocolXmpp
            self.pipes
            self.pipesSafe
            self.prettyShow
            self.randomFu
            self.regexTdfa
            self.regexTdfaText
            self.SafeSemaphore
            self.statistics
            self.statvfs
            self.templateDefault
            self.thyme
            self.utf8String
            self.utilityHt
            self.vectorAlgorithms
            self.vectorThUnbox
            self.zipArchive
            self.X11
            self.xtest
        ]);
    };
}
