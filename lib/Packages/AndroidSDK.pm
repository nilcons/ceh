package Packages::AndroidSDK;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install_bin("androidsdk_4_1", nixpkgs_version => '50f482288857f679acf10cd8a9b3f35a76466730', derivation => '48jpvzrcn7v1klsmn2gq2cpdhv7ld32s-android-sdk-22.2.drv', out => 'w6hrl6yb5g2vghkd4dr4x2b28sr47lzc-android-sdk-22.2');

1;
