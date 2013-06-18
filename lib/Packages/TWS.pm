package Packages::TWS;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

$ENV{NIXPKGS_CONFIG}='/opt/ceh/lib/Packages/TWS.nix';
ceh_nixpkgs_install("tws", nixpkgs_version => '25777d2aca0221beb67311085f24698d401af080', derivation => 'y87l15z4322zz9346nbss5qn7b3yxhnl-tws-937.drv', out => '8qbl16x2w04bqpg33rqn24wz6659mkip-tws-937');

1;
