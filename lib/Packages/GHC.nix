# Used by ghc and co.

{
  packageOverrides = pkgs: {
    cehGHC = pkgs.haskellPackages_ghc783_profiling.ghcWithPackagesOld (hs:
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
        hs.alex
        hs.happy
        hs.primitive

        # command line tools
        hs.ghcMod
        #hs.ghcVis
        #hs.ghcHeapView

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
        hs.foldl
        hs.Glob

        # TODO(errge): gloss depends on bmp, that accidentally loads in a new binary
        # having two binary in the same package db is never good, so disable gloss for now
        # but please remember to put it back, once nixpkgs is fixed.
        #hs.gloss
        # but we add gloss dependencies, so at least building by hand is faster
        hs.OpenGL
        hs.GLUT
        # end of gloss dependencies

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
        hs.statistics
        hs.statvfs
        hs.templateDefault
        hs.temporary
        hs.testFramework
        hs.testFrameworkHunit
        hs.testFrameworkQuickcheck2
        hs.testFrameworkTh
        hs.thyme
        hs.tls
        hs.trifecta
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
        hs.zeromq4Haskell

        # Selected by FP Complete
        hs.basicPrelude
        hs.classyPreludeConduit
        hs.conduitCombinators
        hs.conduitExtra
        hs.doubleConversion
        hs.hamlet
        hs.httpClient
        hs.httpClientTls
        hs.httpConduit
        hs.httpTypes
        hs.pathPieces
        hs.persistent
        hs.persistentTemplate
        hs.shakespeare
        hs.shakespeareCss
        hs.uuid
        hs.xmlConduit
        hs.yesod
        hs.yesodStatic
        hs.zlibConduit

        # Selected for Cloud Haskell
        hs.networkTransportTcp
        hs.distributedProcess
        hs.multimap
        hs.sodium
      ]
    );
  };
}
