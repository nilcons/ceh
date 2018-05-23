package Packages::Emacs;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("emacs", nixpkgs_version => 'c29d2fde74d03178ed42655de6dee389f2b7d37f', out => 'ikbxrga6fd3zbaj2gbkcda2fh56jx2i1-emacs-25.3');

1;
