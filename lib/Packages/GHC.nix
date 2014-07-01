# Used by ghc and co.

{
  packageOverrides = pkgs: {
    cehGHC = pkgs.haskellPackages_ghc763_profiling.ghcWithPackagesOld (hs:
      [
        # Selected from Haskell Platform:
        hs.attoparsec
        hs.fgl
        hs.haskellSrc
        hs.hashable
        hs.html
        hs.HTTP
        hs.HUnit
        hs.mtl
        hs.network
        hs.parallel
        hs.parsec
        hs.QuickCheck
        hs.random
        hs.regexBase
        hs.regexCompat
        hs.regexPosix
        hs.split
        hs.stm
        hs.syb
        hs.text
        hs.transformers
        hs.unorderedContainers
        hs.vector
        hs.xhtml
        hs.zlib
        hs.cabalInstall_1_18_0_3
        hs.Cabal_1_18_1_3
        hs.alex
        # don't specify haddock, it's shipped with ghc in Nix, if
        # specified again, we get collissions
        hs.happy
        hs.primitive

        # command line tools
        hs.hlint
        hs.hoogle
        hs.cabal2nix
        hs.cabalGhci
        hs.ghcMod
        hs.ghcVis
        hs.ghcHeapView
        hs.hakyll
        hs.pandoc

        # compilation tools
        hs.c2hs
        hs.hscolour

        # Selected by CEH
        hs.async
        hs.bindingsPosix
        hs.bytedump
        hs.unixBytestring
        hs.ChartGtk
        hs.colour
        hs.conduit
        hs.criterion
        hs.cryptoApi
        hs.cryptohash
        hs.curl
        hs.dataAccessor
        hs.dataAccessorTemplate
        hs.dataDefault
        hs.dataMemocombinators
        hs.deepseqTh
        hs.digest
        hs.directSqlite
        hs.elerea
        hs.filemanip
        hs.Glob
        hs.gloss
        hs.gtk
        hs.haskeline
        hs.haskellSrcExts
        hs.HFuse
        hs.hmatrix
        hs.hflags
        hs.hit
        hs.hslogger
        hs.HsOpenSSL
        hs.hspec
        hs.hybridVectors
        hs.kanExtensions
        hs.lens
        hs.lensDatetime
        hs.linear
        hs.mimeMail
        hs.MissingH
        hs.modularArithmetic
        hs.monadLoops
        hs.ncurses
        hs.networkConduit
        hs.networkProtocolXmpp
        hs.pipes
        hs.pipesBytestring
        hs.pipesParse
        hs.pipesSafe
        hs.pipesZlib
        hs.prettyShow
        hs.randomFu
        hs.regexTdfa
        hs.regexTdfaText
        hs.SafeSemaphore
        hs.sqliteSimple
        hs.snap
        hs.snapBlaze
        # Have to uncomment statistics, otherwise we get broken
        # packages.  Statistics will still be installed, because
        # criterion depends on it.  We should investigate this WTF.
        # hs.statistics
        hs.statvfs
        hs.templateDefault
        hs.temporary
        hs.testFramework
        hs.testFrameworkHunit
        hs.testFrameworkQuickcheck2
        hs.testFrameworkTh
        hs.thyme
        hs.tls
        hs.tz
        hs.tzdata
        hs.unixTime
        hs.utf8String
        hs.utilityHt
        hs.vectorAlgorithms
        hs.vectorThUnbox
        hs.zipArchive
        hs.X11
        hs.xtest
      ]
    );
  };
}
