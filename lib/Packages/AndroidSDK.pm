package Packages::AndroidSDK;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("androidsdk_4_1", nixpkgs_version => 'd82d86eb64b159cc821261ec31c528cf97a68382', derivation => '1rc2dnif8knzdfrnr5615bcyir8zjfxq-android-sdk-21.drv', out => 'yyc0l7b6ahxb373rfw2vhgh0w2xjklbd-android-sdk-21');

1;
