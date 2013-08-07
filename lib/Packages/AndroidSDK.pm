package Packages::AndroidSDK;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install_bin("androidsdk_4_1", nixpkgs_version => 'b253eb0d593cb1041bd9c87ab03dbf72295c79d6', derivation => 'sh03ii80jjhzxspymqc1iqmva5yshv7d-android-sdk-21.drv', out => 'sgz1s4rj3m45z1vxpww3chik7z1bq6dr-android-sdk-21');

1;
