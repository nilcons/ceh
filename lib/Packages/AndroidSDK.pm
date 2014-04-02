package Packages::AndroidSDK;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install_bin("androidsdk_4_1", nixpkgs_version => '9a396b38405c951bc4f8a5aaebf5262789e2a325', out => '2hw6pxc6yk9qngxnqsrsh51n0pz2mfp1-android-sdk-22.3');

1;
