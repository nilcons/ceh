package Packages::AndroidSDK;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("androidsdk_4_4", nixpkgs_version => '551296a1cec0b9751ab96c420a7481e322ea127d', out => '8hmlk9kjq20nxlris5h9yybz2y8xd8rz-android-sdk-24.4');

1;
