package Packages::NixOps;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nixops_root);

our $ceh_nixops_root = '';

$ENV{NIXPKGS_CONFIG}="/opt/ceh/lib/Packages/NixOps.nix";

if ($ENV{CEH_NIXOPS64}) {
    $ceh_nixops_root=ceh_nixpkgs_install("cehNixOps64", set_nix_path => 1, bit64 => 1, nixpkgs_version => 'a38ae3c9367f9b5b2c4df437b97f3fcff294b9f7', out => 'wbjg9bq4532rx4jrmlmw9q1zjx69irz7-nixops-1.2pre0_abcdef');
} else {
    $ceh_nixops_root=ceh_nixpkgs_install("cehNixOps", set_nix_path => 1, nixpkgs_version => 'a38ae3c9367f9b5b2c4df437b97f3fcff294b9f7', out => 'j7127wdikic8d9rv0zjdjqvrgr6wwlb2-nixops-1.2pre0_abcdef');
}

1;
