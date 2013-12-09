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
    ceh_nixpkgs_install_bin64("tws", nixpkgs_version => '50f482288857f679acf10cd8a9b3f35a76466730', derivation => 'fan0bdxkwfh6aa8dzx8y3vb5bf1dpmx5-tws-20131209.drv', out => '9gxb93ayq33v3z347xrnkdzkhrpav8ch-tws-20131209');
} else {
    ceh_nixpkgs_install_bin("tws", nixpkgs_version => '50f482288857f679acf10cd8a9b3f35a76466730', derivation => 'jyglr7zfz1cccwf61smglgnf3rlsw0cy-tws-20131209.drv', out => '6ldnxygyr9fyhi0d1qx4mscvj3g7p445-tws-20131209');
}

1;
