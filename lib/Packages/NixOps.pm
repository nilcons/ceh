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
    $ceh_nixops_root=ceh_nixpkgs_install("cehNixOps64", set_nix_path => 1, bit64 => 1, nixpkgs_version => 'f666bf4ddf3f5f50cad6e17907dae53d545444d0', out => 'mwr68sxgsxrax9ms1racgci31ln4ns2k-nixops-1.2pre0_abcdef');
} else {
    $ceh_nixops_root=ceh_nixpkgs_install("cehNixOps", set_nix_path => 1, nixpkgs_version => 'f666bf4ddf3f5f50cad6e17907dae53d545444d0', out => 'iiyc5qzyrvq6hyl0hirimy2jrm36d71k-nixops-1.2pre0_abcdef');
}

1;
