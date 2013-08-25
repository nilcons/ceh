package Packages::TWS;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

$ENV{NIXPKGS_CONFIG}='/opt/ceh/lib/Packages/TWS.nix';
ceh_nixpkgs_install_bin("tws", nixpkgs_version => 'c9318f4d2d28d9716699c92280eccb4f12638aef', derivation => 'k7g164x2bs3b5wf7ygicn853xf895h0a-tws-937.drv', out => '76c99vb5f4mf4nf63zfx4r4alm2hjy1c-tws-937');

1;
