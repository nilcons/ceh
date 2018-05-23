package Packages::AndroidSDK;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("androidsdk", nixpkgs_version => 'c29d2fde74d03178ed42655de6dee389f2b7d37f', out => 'shpjymm086b24md8a24rrlx40zzyl5f4-android-sdk-25.2.5');

1;
