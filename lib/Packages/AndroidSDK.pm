package Packages::AndroidSDK;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install_bin("androidsdk_4_1", nixpkgs_version => 'db12d783ffd753145119c22a34ca5945e9a7a4ce', derivation => '49m1wh2ji4gg9vm75pln2l9bav2j54v1-android-sdk-22.3.drv', out => '5d3cp664nmhmxhqncbk1axbwcar5lpj3-android-sdk-22.3');

1;
