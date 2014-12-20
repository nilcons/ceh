package Packages::AndroidSDK;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("androidsdk_4_4", nixpkgs_version => '3d74b3810104878527f0fde8aad65908579a504e', out => 'c61v0myyw34rbf9zh71mhpib0k7k1x2n-android-sdk-23.0.2');

1;
