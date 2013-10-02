package Packages::GitAnnex;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install_bin("gitAndTools.gitAnnex", nixpkgs_version => 'e26b828f4a3f00c89497913970ca2fef8441367f', derivation => 'bfz9h8wr17cgqa342hywldkx460xfgnn-git-annex-4.20130909.drv', out => 'y31kbrg9mh3b6dl00y60nzjy114qplmd-git-annex-4.20130909');

1;
