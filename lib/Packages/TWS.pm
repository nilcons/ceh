package Packages::TWS;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

$ENV{NIXPKGS_CONFIG}='/opt/ceh/lib/Packages/TWS.nix';
if ($ENV{CEH_TWS64}) {
    ceh_nixpkgs_install_bin64("tws", nixpkgs_version => '50f482288857f679acf10cd8a9b3f35a76466730', derivation => 'w69nh2gyzipglg7zcivpwf3rxlz8znp6-tws-20130128.drv', out => 'phhj15jxc6kbm3g1qvgr7a17q7zmxhr1-tws-20130128');
} else {
    ceh_nixpkgs_install_bin("tws", nixpkgs_version => '50f482288857f679acf10cd8a9b3f35a76466730', derivation => 'y45yssfxgdxrc4k41z9bky8hkx9yf2hk-tws-20130128.drv', out => 'rlxp3ffib8drf4lz7v1ymxhwspkcm1f3-tws-20130128');
}

1;
