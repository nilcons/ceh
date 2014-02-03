package Packages::GitAnnex;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install_bin("gitAndTools.gitAnnex", nixpkgs_version => 'ba4461f96f14b322ebd03d9cbcf4e0fdc206d595', derivation => 'zyk7xcfsg35dqhvrmzn9fy9fygh6ka2s-git-annex-5.20140129.drv', out => 'iga6c14b858s2py7bv9srfn0qfiwyj9i-git-annex-5.20140129');

1;
