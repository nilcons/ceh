package Packages::AndroidSDK;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("androidsdk_4_1", nixpkgs_version => '168115f610835654c1ed85a1bcf089f0919c9566', derivation => '7mm3nwb0xwa1638i5x2w1pnpxqk4r0sf-android-sdk-21.drv', out => '1x6pkk9znn3w070xwf1cam99hyap3wvm-android-sdk-21');

1;
