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
    ceh_nixpkgs_install_bin64("tws", nixpkgs_version => 'e26b828f4a3f00c89497913970ca2fef8441367f', derivation => 'b5f4ypbhbfxl6qgslgdc8r76grkx7j70-tws-20131020.drv', out => 'ckicjfxslb0q4cvawjp307br7ijhy235-tws-20131020');
} else {
    ceh_nixpkgs_install_bin("tws", nixpkgs_version => 'e26b828f4a3f00c89497913970ca2fef8441367f', derivation => '51w88rqc2cj8qazdqgqcvwwh6pfgd91m-tws-20131020.drv', out => '00k21ilqky0xcjaa8qwipqkvhwijr2z6-tws-20131020');
}

1;
