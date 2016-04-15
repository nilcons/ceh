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

if (defined($ENV{CEH_JAVAFLAVOR}) && $ENV{CEH_JAVAFLAVOR} eq "sun6") {
    ceh_nixpkgs_install("oraclejdk", nixpkgs_version => '551296a1cec0b9751ab96c420a7481e322ea127d', out => 'kg50ija6gashs2zkkjf0ir9m6xc8vn8b-jdk-1.6.0_45b06');
} elsif (defined($ENV{CEH_JAVAFLAVOR}) && $ENV{CEH_JAVAFLAVOR} eq "sun7") {
    ceh_nixpkgs_install("oraclejdk7", nixpkgs_version => '551296a1cec0b9751ab96c420a7481e322ea127d', out => '84gym9ngkk195x9p3xb20pvg114gnhmg-oraclejdk-7u79');
} elsif (defined($ENV{CEH_JAVAFLAVOR}) && $ENV{CEH_JAVAFLAVOR} eq "sun8") {
    ceh_nixpkgs_install("oraclejdk8", nixpkgs_version => '551296a1cec0b9751ab96c420a7481e322ea127d', out => '63qdvdcqy8v70sgx1z432pvfqixgd7f3-oraclejdk-8u77');
} else {
    ceh_nixpkgs_install("openjdk", nixpkgs_version => '551296a1cec0b9751ab96c420a7481e322ea127d', out => 'n35viakx3wj9rhl1brrw23blzhl03rm0-openjdk-8u76b00');
}

1;
