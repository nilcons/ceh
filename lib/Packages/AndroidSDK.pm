package Packages::AndroidSDK;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("androidsdk_4_1", nixpkgs_version => '25777d2aca0221beb67311085f24698d401af080', derivation => '99nb6ydxm364v5q0kbglz5h8v91yp19f-android-sdk-21.drv', out => 'pas2wbjabjaqk7zwcxj4dwgc7vizl6yy-android-sdk-21');

1;
