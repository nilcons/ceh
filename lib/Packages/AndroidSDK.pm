package Packages::AndroidSDK;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("androidsdk_4_1", nixpkgs_version => '008bb6935cddd3708ac4caf3360afb603ee5b4fa', derivation => 'lxs36im4z0y9mll3rnq2j688cyfd0f6j-android-sdk-21.drv', out => 'yyc0l7b6ahxb373rfw2vhgh0w2xjklbd-android-sdk-21');

1;
