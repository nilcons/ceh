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
    $ceh_nixops_root=ceh_nixpkgs_install("cehNixOps64", set_nix_path => 1, bit64 => 1, nixpkgs_version => 'c6261157f812eff0cdecc7cba3ee29be9224c4eb', out => 'd615g49d4s10331x195j1nawdl8z79py-nixops-1.2pre0_abcdef');
} else {
    $ceh_nixops_root=ceh_nixpkgs_install("cehNixOps", set_nix_path => 1, nixpkgs_version => 'c6261157f812eff0cdecc7cba3ee29be9224c4eb', out => 'zqnrpvh659kdvqf4zcicplrxbrllqnpb-nixops-1.2pre0_abcdef');
}

1;
