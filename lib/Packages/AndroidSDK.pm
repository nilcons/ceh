package Packages::AndroidSDK;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("androidsdk_4_1", nixpkgs_version => 'f666bf4ddf3f5f50cad6e17907dae53d545444d0', out => '2bfkymdlifszhihail28rc1x5infylsr-android-sdk-22.6.2');

1;
