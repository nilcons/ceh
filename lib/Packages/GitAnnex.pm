package Packages::GitAnnex;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("gitAndTools.gitAnnex", nixpkgs_version => '25777d2aca0221beb67311085f24698d401af080', derivation => '38bs3mglg7nay4h85d6l0a92fh2zlf4r-git-annex-4.20130601.drv', out => 'r4bky6hxmg73azmpis2y97vdlmbn45a0-git-annex-4.20130601');

1;
