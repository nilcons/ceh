package Packages::TigerVNC;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install_bin("tigervnc", nixpkgs_version => '9a396b38405c951bc4f8a5aaebf5262789e2a325', out => 'qk4k85hx12nxycqyn7rlfdpwnqvczibd-tigervnc-r5129');

1;
