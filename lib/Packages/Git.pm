package Packages::Git;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("gitAndTools.gitFull", nixpkgs_version => 'f666bf4ddf3f5f50cad6e17907dae53d545444d0', out => 'np0s05j80jz414lknjmzbiny4g79pfhb-git-2.0.1');

1;
