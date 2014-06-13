package Packages::AndroidSDK;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("androidsdk_4_1", nixpkgs_version => 'c6261157f812eff0cdecc7cba3ee29be9224c4eb', out => 'jxljp9mrpbqciqf77cqzwn0dwd5a82ps-android-sdk-22.6.2');

1;
