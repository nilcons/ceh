package Packages::TigerVNC;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("tigervnc", nixpkgs_version => 'c29d2fde74d03178ed42655de6dee389f2b7d37f', out => '8534z0nmjicrc0icahpbzx3jvg6kvzm7-tigervnc-1.8.0pre20170419');

1;
