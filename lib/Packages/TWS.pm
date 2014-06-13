package Packages::TWS;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

$ENV{NIXPKGS_CONFIG}='/opt/ceh/lib/Packages/TWS.nix';
ceh_nixpkgs_install("tws", nixpkgs_version => 'c6261157f812eff0cdecc7cba3ee29be9224c4eb', out => '65wwzh49wjghhyx4l0c21qmpksm5iyl0-tws-20130531');

1;
