FROM nilcons/ceh:base
MAINTAINER Gergely Risko <errge@nilcons.com>

ENV CEH_GHC32=
RUN /opt/ceh/scripts/ghc-build-shell.pl </dev/null 2>&1 | tee haskell-64-build.log
ENV CEH_GHC32=1
RUN /opt/ceh/scripts/ghc-build-shell.pl </dev/null 2>&1 | tee haskell-32-build.log
ENV CEH_GHC32=
