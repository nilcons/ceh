package Packages::TWS;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

$ENV{NIXPKGS_CONFIG}='/opt/ceh/lib/Packages/TWS.nix';
ceh_nixpkgs_install("tws", nixpkgs_version => 'd82d86eb64b159cc821261ec31c528cf97a68382', derivation => 'f012knzby53m025b0arvzg0fyd7sq8al-tws-937.drv', out => 'wsv8jq3mw7jzbx52147s66k40z7cb4kw-tws-937');

1;
