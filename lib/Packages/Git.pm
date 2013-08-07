package Packages::Git;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install_bin("gitAndTools.gitFull", nixpkgs_version => 'b253eb0d593cb1041bd9c87ab03dbf72295c79d6', derivation => '453vk4ismcyqh7p13r07mvnfzxgm9l2c-git-1.8.3.2.drv', out => '2wlf3ds2jw7y3sgxnlp2ilaya8jfll60-git-1.8.3.2');

1;
