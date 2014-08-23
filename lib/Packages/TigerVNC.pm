package Packages::TigerVNC;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("tigervnc", nixpkgs_version => 'a38ae3c9367f9b5b2c4df437b97f3fcff294b9f7', out => '2dvr1kv352lc2n8iwvbad4k8hdsskypm-tigervnc-r5129');

1;
