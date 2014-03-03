package Packages::Git;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install_bin("gitAndTools.gitFull", nixpkgs_version => 'db12d783ffd753145119c22a34ca5945e9a7a4ce', derivation => 'ciynf5cq75gyy5h2rbc9hs17pm6w6475-git-1.8.5.2.drv', out => '5y94qn658kfdvrkzimfnh7dg7k9jfsxg-git-1.8.5.2');

1;
