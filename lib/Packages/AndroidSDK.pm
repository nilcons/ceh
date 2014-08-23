package Packages::AndroidSDK;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("androidsdk_4_1", nixpkgs_version => 'a38ae3c9367f9b5b2c4df437b97f3fcff294b9f7', out => 'cnfbldwrv3p16sa56m8mdi893snfn2mj-android-sdk-22.6.2');

1;
