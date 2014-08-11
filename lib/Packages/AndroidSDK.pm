package Packages::AndroidSDK;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("androidsdk_4_1", nixpkgs_version => '0852d9e3643458ebd435b366bb3ecd79b0f47400', out => 'ix791hsjaa23ld4k216vjbqraqb77d1w-android-sdk-22.6.2');

1;
