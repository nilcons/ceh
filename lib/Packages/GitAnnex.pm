package Packages::GitAnnex;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("gitAndTools.gitAnnex", nixpkgs_version => '551296a1cec0b9751ab96c420a7481e322ea127d', out => '9ivxmwkaacjflz8j623kx8x1fbbma12s-git-annex-6.20160318');

1;
