package Packages::GitAnnex;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("gitAndTools.gitAnnex", nixpkgs_version => 'c6261157f812eff0cdecc7cba3ee29be9224c4eb', out => '0ychwlb4klh0xaf7rgkqrzry6wvclhhk-git-annex-5.20140517');

1;
