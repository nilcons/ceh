package Packages::GitAnnex;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("gitAndTools.gitAnnex", nixpkgs_version => 'e07ea5cf77601325b16f51fb457b90d5aadfab6f', out => 'czag45903r5iy2b0xbccx7z5sgcmnwjs-git-annex-5.20150219');

1;
