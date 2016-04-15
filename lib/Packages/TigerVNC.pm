package Packages::TigerVNC;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("tigervnc", nixpkgs_version => '551296a1cec0b9751ab96c420a7481e322ea127d', out => 'lw4ad1zfsy8kgkqp9vgp5v3wjg85bcgr-tigervnc-1.6.0');

1;
