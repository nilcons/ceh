package Packages::GHC;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_ghc_root);

ceh_init_gcc_env_for_ghc();

path_prepend('/nix/var/nix/profiles/ceh/ghc-libs/lib', 'LD_LIBRARY_PATH');

1;
