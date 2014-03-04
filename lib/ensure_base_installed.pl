#!/bin/sh
set -e
if ! [ -x "$ENSURE_BASE_PERL" ]; then echo >&2 "ENSURE_BASE_PERL env var not set"; exit 1; fi
if ! [ -d "$ENSURE_BASE_NIXPATH" ]; then echo >&2 "ENSURE_BASE_NIXPATH env var not set"; exit 1; fi
exec $ENSURE_BASE_PERL -x $0
#! -*- mode: perl -*-

#line 8
# ^^^^^ This is needed, because perl -x is buggy.

# This perl script is used in ceh-init.sh to install the correct
# version of nix and perl into the essential profile by only using nix
# tools given in ENSURE_BASE_NIXPATH:
#  - in the case of Ubuntu, Debian, etc. this is a minimal
#    bootstrap.tar.gz downloaded from hydra,
#  - in the case of NixOS, this is simply /run/current_system/sw.

use strict;
use warnings;
use lib "/opt/ceh/lib";
use CehBase ( nixpath => $ENV{ENSURE_BASE_NIXPATH} );
use CehInstall;

ensure_base_installed();
