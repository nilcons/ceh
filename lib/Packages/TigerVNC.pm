package Packages::TigerVNC;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("tigervnc", nixpkgs_version => '3d74b3810104878527f0fde8aad65908579a504e', out => 'cj10j4qjj7yfxlp8v6d7dx8winjfmhvj-tigervnc-1.3.1');

1;
