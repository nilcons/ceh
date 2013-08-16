package Packages::AndroidSDK;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install_bin("androidsdk_4_1", nixpkgs_version => '1f2ecd08cc28d0d199d7f0304da9d8bbc2ff6239', derivation => '3mpybm0mz5lg1m8dskkhk3mz60ima3md-android-sdk-22.05.drv', out => '3xfgwqa7za1wyyvbhbyx42pni4iw79qk-android-sdk-22.05');

1;
