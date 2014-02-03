package Packages::AndroidSDK;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install_bin("androidsdk_4_1", nixpkgs_version => 'ba4461f96f14b322ebd03d9cbcf4e0fdc206d595', derivation => 'cj1vlqczrrlyp07yjc8q3zc9v1bs5szn-android-sdk-22.3.drv', out => 'z6rbl71m9nxkx24fxsrk45wmi9fl4jz2-android-sdk-22.3');

1;
