package Packages::Git;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install_bin("gitAndTools.gitFull", nixpkgs_version => 'ba4461f96f14b322ebd03d9cbcf4e0fdc206d595', derivation => 'vf461mqbdvcjh9v3y2ibjavkj3rv6gab-git-1.8.5.2.drv', out => '77i782mlb5vbaw2ky3f0cisjbnhbnbwf-git-1.8.5.2');

1;
