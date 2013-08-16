package Packages::Git;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install_bin("gitAndTools.gitFull", nixpkgs_version => '1f2ecd08cc28d0d199d7f0304da9d8bbc2ff6239', derivation => 'izn8d3x0l6vaa6zapjv3jr4y85cknh87-git-1.8.3.4.drv', out => '4k7lzmf8hkq12823xn6mpk82bbqlv1i6-git-1.8.3.4');

1;
