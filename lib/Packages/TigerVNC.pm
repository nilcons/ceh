package Packages::TigerVNC;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("tigervnc", nixpkgs_version => '8392c8ba9f5eefbd13a0956b75f7253405135ec8', out => 'ki29p4nkhr712p2r6hk1zm09071ma1w5-tigervnc-r5129');

1;
