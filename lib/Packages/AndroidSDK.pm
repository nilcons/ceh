package Packages::AndroidSDK;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("androidsdk", nixpkgs_version => '02a268430e13061aad441ec4a28579d46af79e33', out => '5izzfzgiqbj1wbs18dy6fyq7v03imxny-android-sdk-25.2.3');

1;
