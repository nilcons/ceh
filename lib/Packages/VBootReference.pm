package Packages::VBootReference;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

$ENV{NIXPKGS_CONFIG}='/opt/ceh/lib/Packages/VBootReference.nix';
ceh_nixpkgs_install("vboot_reference", nixpkgs_version => '25777d2aca0221beb67311085f24698d401af080', derivation => '15yhffxbzjpn2yr4yb0p3bp0bc62cic4-vboot_reference-37.43837.2.drv', out => 'zmk9v0li2p1fzclkv99q95l91p5k52i3-vboot_reference-37.43837.2');

1;
