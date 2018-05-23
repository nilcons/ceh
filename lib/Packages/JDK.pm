package Packages::JDK;

use strict;
use warnings;
use CehBase;
use CehInstall;
use feature qw(switch);

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

# (while (re-search-forward "nixpkgs_version =>" nil t) (backward-word 2) (kill-line) (insert "AUTOINIT);"))

$ENV{NIXPKGS_CONFIG}='/opt/ceh/lib/Packages/allownonfree.nix';

if (defined($ENV{CEH_JAVAFLAVOR}) && $ENV{CEH_JAVAFLAVOR} eq "sun8") {
    ceh_nixpkgs_install("oraclejdk", nixpkgs_version => 'c29d2fde74d03178ed42655de6dee389f2b7d37f', out => '9dqimifwm7yzry650rnq498m14s65269-oraclejdk-8u171');
} else {
    ceh_nixpkgs_install("openjdk", nixpkgs_version => 'c29d2fde74d03178ed42655de6dee389f2b7d37f', out => 'jrqmd185hh0hb12agkrlfzy6v1bi1djj-openjdk-8u172b11');
}

1;
