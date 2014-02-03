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
    ceh_nixpkgs_install_bin64("tws", nixpkgs_version => 'ba4461f96f14b322ebd03d9cbcf4e0fdc206d595', derivation => '3dp01ksbq32qprvn75c7a44dfv531rda-tws-20130128.drv', out => 'nn13bwy7iqxpw941y0ka5pp1dhf318px-tws-20130128');
} else {
    ceh_nixpkgs_install_bin("tws", nixpkgs_version => 'ba4461f96f14b322ebd03d9cbcf4e0fdc206d595', derivation => '5j0lwx83qf7ly7g5drs0lwmf0jvd8mva-tws-20130128.drv', out => 'ajfr0a280ffhz8y4s9jkjmxjy30fp144-tws-20130128');
}

1;
