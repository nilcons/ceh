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
    $ceh_nixops_root=ceh_nixpkgs_install("cehNixOps64", set_nix_path => 1, bit64 => 1, nixpkgs_version => '8392c8ba9f5eefbd13a0956b75f7253405135ec8', out => '92hadav73yj2xq7xv3brg2l75bdjj8ip-nixops-1.2pre0_abcdef');
} else {
    $ceh_nixops_root=ceh_nixpkgs_install("cehNixOps", set_nix_path => 1, nixpkgs_version => '8392c8ba9f5eefbd13a0956b75f7253405135ec8', out => '98hfhd05i7s0xbjxnc5rnzh576wh4sly-nixops-1.2pre0_abcdef');
}

1;
