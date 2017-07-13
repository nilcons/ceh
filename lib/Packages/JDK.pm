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
    ceh_nixpkgs_install("oraclejdk", nixpkgs_version => '02a268430e13061aad441ec4a28579d46af79e33', out => 'az6mkc7hfdznka70mdz4460rlzlcp26v-oraclejdk-8u131');
} else {
    ceh_nixpkgs_install("openjdk", nixpkgs_version => '02a268430e13061aad441ec4a28579d46af79e33', out => 'v0b7bmiwivq70jnw9cw45dlglmxxvwlc-openjdk-8u131b11');
}

1;
