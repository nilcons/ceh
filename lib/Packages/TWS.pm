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
    ceh_nixpkgs_install_bin64("tws", nixpkgs_version => 'e26b828f4a3f00c89497913970ca2fef8441367f', derivation => 'kh61dvs4sa96ds046g3pcfx5hd073na1-tws-20130920.drv', out => 'wbzgj8fdxmlhjfhkkzjl430clc10a4jp-tws-20130920');
} else {
    ceh_nixpkgs_install_bin("tws", nixpkgs_version => 'e26b828f4a3f00c89497913970ca2fef8441367f', derivation => 'hyjvnc46f7228gifahigsj6iwhybm63h-tws-20130920.drv', out => 'i3v3jbiawxgmphhk4sbpz5s02yxd6rlw-tws-20130920');
}

1;
