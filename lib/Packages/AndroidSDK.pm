package Packages::AndroidSDK;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("androidsdk_4_4", nixpkgs_version => 'e07ea5cf77601325b16f51fb457b90d5aadfab6f', out => '21w8378nyi25zdskn2fnpak2ay4vssc7-android-sdk-24.0.1');

1;
