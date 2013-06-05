package Packages::Emacs;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("emacs", nixpkgs_version => 'd82d86eb64b159cc821261ec31c528cf97a68382', derivation => 'khr8rjvs2wc9cnbv4p65c3ypx80cvqna-emacs-24.3.drv', out => 'b0ckwqsvsfghvl2v3mxp24gp28kipy1z-emacs-24.3');

1;
