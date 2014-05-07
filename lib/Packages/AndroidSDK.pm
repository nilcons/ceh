package Packages::AndroidSDK;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("androidsdk_4_1", nixpkgs_version => '8392c8ba9f5eefbd13a0956b75f7253405135ec8', out => 'vqxdawps6m4r8xi8hay6ypk2c1l0rrl6-android-sdk-22.3');

1;
