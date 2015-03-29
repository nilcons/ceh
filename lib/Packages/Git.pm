package Packages::Git;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("gitAndTools.gitFull", nixpkgs_version => 'e07ea5cf77601325b16f51fb457b90d5aadfab6f', out => 'dlcp6j45kgf74cjawpwszaii5bghy8hd-git-2.3.2');

1;
