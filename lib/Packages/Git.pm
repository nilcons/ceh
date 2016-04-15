package Packages::Git;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("gitAndTools.gitFull", nixpkgs_version => '551296a1cec0b9751ab96c420a7481e322ea127d', out => '403xyx2w6kmycglzk8m8wwb7czxk3593-git-2.8.0');

1;
