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
    ceh_nixpkgs_install_bin64("tws", nixpkgs_version => '50f482288857f679acf10cd8a9b3f35a76466730', derivation => '0g9jh83kd709l7s2ghjgch1v3mq1f43y-tws-20130108.drv', out => 'im6mdic03zxgzf3wymy4nf5g4mrk8kk6-tws-20130108');
} else {
    ceh_nixpkgs_install_bin("tws", nixpkgs_version => '50f482288857f679acf10cd8a9b3f35a76466730', derivation => 'a6nb223k92z4kgkgj9npzvfc7h9pvzdq-tws-20130108.drv', out => 'hxg58g7vwz9wd4k17miwp208p0881ap0-tws-20130108');
}

1;
