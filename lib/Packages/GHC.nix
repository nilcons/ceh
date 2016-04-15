# Used by ghc and co.

{
  packageOverrides = super: let self = super.pkgs; in
    { cehGHC = self.haskellPackages.ghcWithHoogle (hs:
      [
        # Selected from Haskell Platform:
        hs.attoparsec
        hs.fgl
        hs.haskell-src
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
        hs.regex-base
        hs.regex-compat
        hs.regex-posix
        hs.split
        hs.stm
        hs.syb
        hs.text
        hs.transformers
        hs.unordered-containers
        hs.vector
        hs.xhtml
        hs.zlib
        hs.alex
        hs.happy
        hs.primitive

        # command line tools
        hs.ghc-mod
        #hs.ghc-vis
        #hs.ghc-heap-view

        # Selected by CEH
        hs.async
        # arithmoi broken on 32-bit currently
        # https://github.com/cartazio/arithmoi/issues/13
        ] ++ (if (self.stdenv.system == "x86_64-linux") then [ hs.arithmoi ] else []) ++ [
        hs.bindings-posix
        hs.bytedump
        hs.unix-bytestring
        hs.Chart-gtk
        hs.colour
        hs.conduit
        hs.criterion
        hs.crypto-api
        hs.cryptohash
        hs.curl
        hs.data-accessor
        hs.data-accessor-template
        hs.data-default
        hs.data-memocombinators
        # broken in ghc 7.10
        # hs.deepseq-th
        hs.digest
        hs.digits
        hs.direct-sqlite
        hs.elerea
        hs.filemanip
        hs.foldl
        hs.Glob

        hs.gloss

        hs.gtk
        hs.haskeline
        hs.haskell-src-exts
        hs.HFuse
        hs.hmatrix
        hs.hflags
        hs.hit
        hs.hslogger
        hs.HsOpenSSL
        hs.hspec
        hs.hybrid-vectors
        hs.kan-extensions
        hs.lens
        hs.lens-datetime
        hs.linear
        hs.mime-mail
        hs.MissingH
        hs.modular-arithmetic
        hs.monad-loops
        hs.ncurses
        hs.netwire
        hs.network-conduit
        hs.network-protocol-xmpp
        hs.pipes
        hs.pipes-bytestring
        hs.pipes-parse
        hs.pipes-safe
        hs.pipes-zlib
        hs.pretty-show
        hs.primes
        hs.random-fu
        hs.regex-tdfa
        hs.regex-tdfa-rc
        hs.regex-tdfa-text
        hs.SafeSemaphore
        hs.sqlite-simple
        hs.snap
        hs.snap-blaze
        hs.statistics
        hs.statvfs
        # doesn't work with GHC 7.10.3
        # hs.template-default
        hs.temporary
        hs.test-framework
        hs.test-framework-hunit
        hs.test-framework-quickcheck2
        hs.test-framework-th
        hs.thyme
        hs.tls
        hs.trifecta
        hs.tz
        hs.tzdata
        hs.unix-time
        hs.utf8-string
        hs.utility-ht
        hs.vector-algorithms
        hs.vector-th-unbox
        hs.zip-archive
        hs.X11
        hs.xtest
        hs.zeromq4-haskell

        # Selected by FP Complete
        hs.basic-prelude
        hs.classy-prelude-conduit
        hs.conduit-combinators
        hs.conduit-extra
        hs.double-conversion
        hs.hamlet
        hs.http-client
        hs.http-client-tls
        hs.http-conduit
        hs.http-types
        hs.path-pieces
        hs.persistent
        hs.persistent-template
        hs.shakespeare
        hs.shakespeare-css
        hs.uuid
        hs.xml-conduit
        hs.yesod
        hs.yesod-static
        hs.zlib-conduit

        # Selected for Cloud Haskell
        hs.acid-state
        hs.clock
        hs.distributed-process
        hs.multimap
        hs.network-transport-tcp
        hs.tasty
        hs.tasty-hunit
        hs.safecopy
        hs.sodium
        hs.unbounded-delays

        ]);
  };
}
