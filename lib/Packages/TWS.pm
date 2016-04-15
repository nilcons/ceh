package Packages::TWS;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

$ENV{NIXPKGS_CONFIG}='/opt/ceh/lib/Packages/TWS.nix';
ceh_nixpkgs_install("tws", nixpkgs_version => '551296a1cec0b9751ab96c420a7481e322ea127d', out => 'svc6fcb40x1m5qzc80p0gsy5a7agky9v-tws-20160414');

1;
