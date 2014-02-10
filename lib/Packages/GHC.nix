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
            self.cabalInstall_1_18_0_2
            self.Cabal_1_18_1_2
            self.alex_3_1_3
            # seems to be not needed anymore, because nix auto inserts it: self.haddock
            self.happy_1_19_3
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
            self.directSqlite
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
            # self.lens
            self.lensDatetime
            # linear depends on lens4, causing cabal hell
            # self.linear
            self.mimeMail
            self.MissingH
            self.modularArithmetic
            self.monadLoops
            self.ncurses
            self.networkConduit
            self.networkProtocolXmpp
            self.pipes
            self.pipesBytestring
            self.pipesParse
            self.pipesSafe
            self.prettyShow
            self.randomFu
            self.regexTdfa
            self.regexTdfaText
            self.SafeSemaphore
            self.sqliteSimple
            self.snap
            self.snapBlaze
            self.statistics
            self.statvfs
            self.templateDefault
            self.temporary
            self.thyme
            self.tls
            self.unixTime
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
