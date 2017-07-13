package Packages::TigerVNC;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("tigervnc", nixpkgs_version => '02a268430e13061aad441ec4a28579d46af79e33', out => '0xs9yqg6vgdaiyxqvsr68icfzpv2zksd-tigervnc-1.8.0pre20170419');

1;
