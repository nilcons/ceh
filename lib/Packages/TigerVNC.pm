package Packages::TigerVNC;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("tigervnc", nixpkgs_version => 'e07ea5cf77601325b16f51fb457b90d5aadfab6f', out => '2nlhkz82yk6c1g8pvjjczh5r2vkll1jv-tigervnc-1.3.1');

1;
