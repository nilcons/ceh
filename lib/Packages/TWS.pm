package Packages::TWS;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

$ENV{NIXPKGS_CONFIG}='/opt/ceh/lib/Packages/TWS.nix';
ceh_nixpkgs_install("tws", nixpkgs_version => '551296a1cec0b9751ab96c420a7481e322ea127d', out => 'rghcmdgk0lggbl77ibfdp6jvb7aj76x5-tws-20160916');

1;
