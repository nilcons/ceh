package Packages::TigerVNC;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("tigervnc", nixpkgs_version => 'c6261157f812eff0cdecc7cba3ee29be9224c4eb', out => '9b78d79lhqab19m1zcwhj1y9jx3yv6fb-tigervnc-r5129');

1;
