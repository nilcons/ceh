package Packages::TigerVNC;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("tigervnc", nixpkgs_version => '0852d9e3643458ebd435b366bb3ecd79b0f47400', out => '6ybavkp3pa0p5ssx6plv0qm3103pxi6p-tigervnc-r5129');

1;
