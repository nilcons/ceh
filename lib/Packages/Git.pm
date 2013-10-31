package Packages::Git;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install_bin("gitAndTools.gitFull", nixpkgs_version => '50f482288857f679acf10cd8a9b3f35a76466730', derivation => 'mhcnf63c1lyjnjsl4dzv21hvyiyw79r6-git-1.8.4.drv', out => 'ccwlm34x69ijp0bxp4l3yszh3wmwndw1-git-1.8.4');

1;
