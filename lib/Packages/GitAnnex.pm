package Packages::GitAnnex;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

# TODO: https://github.com/NixOS/nixpkgs/pull/3376
ceh_nixpkgs_install("gitAndTools.gitAnnex", nixpkgs_version => 'f666bf4ddf3f5f50cad6e17907dae53d545444d0', out => '9zbsd3b1kqf13icwy892g5ar16y7sfyw-git-annex-5.20140613');

1;
