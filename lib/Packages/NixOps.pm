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
    $ceh_nixops_root=ceh_nixpkgs_install("cehNixOps64", set_nix_path => 1, bit64 => 1, nixpkgs_version => '0852d9e3643458ebd435b366bb3ecd79b0f47400', out => 'qajqf03rb4mk2f440vjymr5lgizrd5fc-nixops-1.2pre0_abcdef');
} else {
    $ceh_nixops_root=ceh_nixpkgs_install("cehNixOps", set_nix_path => 1, nixpkgs_version => '0852d9e3643458ebd435b366bb3ecd79b0f47400', out => 'jsyjvy803vh81lfi0zva31inqhzi07vr-nixops-1.2pre0_abcdef');
}

1;
