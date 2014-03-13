package Packages::TigerVNC;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install_bin("tigervnc", nixpkgs_version => 'db12d783ffd753145119c22a34ca5945e9a7a4ce', out => '0cifb9cnni5ika9dbdg97nqpidxdzfkg-tigervnc-r5129');

1;
