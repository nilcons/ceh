package Packages::GitAnnex;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install_bin("gitAndTools.gitAnnex", nixpkgs_version => '8392c8ba9f5eefbd13a0956b75f7253405135ec8', out => '5xlvkm3890nzmsx3zy052klq828f6ww6-git-annex-5.20140405');

1;
