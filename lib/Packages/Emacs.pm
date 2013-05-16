package Packages::Emacs;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("emacs", nixpkgs_version => '008bb6935cddd3708ac4caf3360afb603ee5b4fa', derivation => '6rsdrcj38xnq9q5kjk6zrv60xif2ynn9-emacs-24.3.drv', out => '5kgkkj06ccd90bj8qjd12295hll9cv5a-emacs-24.3');

1;
