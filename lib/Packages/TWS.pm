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
    ceh_nixpkgs_install_bin64("tws", nixpkgs_version => 'ba4461f96f14b322ebd03d9cbcf4e0fdc206d595', derivation => '50yvg9rha31ly438hmwy20lbnb0j7n9a-tws-20130204.drv', out => '95nvs94nq08xibjn3lyi3gysbq221k7v-tws-20130204');
} else {
    ceh_nixpkgs_install_bin("tws", nixpkgs_version => 'ba4461f96f14b322ebd03d9cbcf4e0fdc206d595', derivation => 'jd9j9dy1lwrkdq1mz884qddlvfg1zv4v-tws-20130204.drv', out => '4pn44znr2r5ndk8p43injyi9zsp2y85a-tws-20130204');
}

1;
