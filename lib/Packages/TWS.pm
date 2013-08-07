package Packages::TWS;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

$ENV{NIXPKGS_CONFIG}='/opt/ceh/lib/Packages/TWS.nix';
ceh_nixpkgs_install_bin("tws", nixpkgs_version => '168115f610835654c1ed85a1bcf089f0919c9566', derivation => '6zlwmsfc5z4kfccic24axjwzlw2nkdm7-tws-937.drv', out => 'j5x0iw5ks3zb014q9y95kjl8jvkvdzjf-tws-937');

1;
