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
    ceh_nixpkgs_install_bin64("tws", nixpkgs_version => '50f482288857f679acf10cd8a9b3f35a76466730', derivation => '4d885160z0gm574jbrf1g6bw2z0dns86-tws-20131109.drv', out => 'nzakid5bcijx6lr9xzms80l6hgl3m97p-tws-20131109');
} else {
    ceh_nixpkgs_install_bin("tws", nixpkgs_version => '50f482288857f679acf10cd8a9b3f35a76466730', derivation => 'vrx634xak89gljrpf7ng3128iizccxwr-tws-20131109.drv', out => '554x86ynhfghzjbdlsn1kb07lkpdmhms-tws-20131109');
}

1;
