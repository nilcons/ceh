package Packages::TWS;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

$ENV{NIXPKGS_CONFIG}='/opt/ceh/lib/Packages/TWS.nix';
ceh_nixpkgs_install_bin("tws", nixpkgs_version => 'db12d783ffd753145119c22a34ca5945e9a7a4ce', derivation => 'dx00h5nlxv2zvbgjaadcdi23iih82gdj-tws-20130211.drv', out => 'wnc7pf82g3jr9qccysj9a9caagvvipf3-tws-20130211');

1;
