package Packages::Git;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install_bin("gitAndTools.gitFull", nixpkgs_version => 'c9318f4d2d28d9716699c92280eccb4f12638aef', derivation => 'izn8d3x0l6vaa6zapjv3jr4y85cknh87-git-1.8.3.4.drv', out => '4k7lzmf8hkq12823xn6mpk82bbqlv1i6-git-1.8.3.4');

1;
