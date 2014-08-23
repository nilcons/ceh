package Packages::Git;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("gitAndTools.gitFull", nixpkgs_version => 'a38ae3c9367f9b5b2c4df437b97f3fcff294b9f7', out => '4a9mw6y3jxn3gcigqjzwh0ki7r8nraay-git-2.0.2');

1;
