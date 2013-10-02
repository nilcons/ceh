package Packages::AndroidSDK;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install_bin("androidsdk_4_1", nixpkgs_version => 'e26b828f4a3f00c89497913970ca2fef8441367f', derivation => '6k6nc4cqx59qy2w2wjaa083b42v6wd0g-android-sdk-22.2.drv', out => 'q11rr7bsgmvg5pqw70a5p7qpzfvchk4h-android-sdk-22.2');

1;
