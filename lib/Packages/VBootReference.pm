package Packages::VBootReference;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("vboot_reference", nixpkgs_version => '551296a1cec0b9751ab96c420a7481e322ea127d', out => 'h5fk1h2dh3fm6b42lcwprbdksp7ckgh4-vboot_reference-20130507');

1;
