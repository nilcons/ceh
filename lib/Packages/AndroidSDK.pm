package Packages::AndroidSDK;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install_bin("androidsdk_4_1", nixpkgs_version => 'db12d783ffd753145119c22a34ca5945e9a7a4ce', derivation => 'dykhm6yh8z6czni3m43023jyzdcdvp0l-android-sdk-22.3.drv', out => '5d3cp664nmhmxhqncbk1axbwcar5lpj3-android-sdk-22.3');

1;
