package Packages::Emacs;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install_bin("emacs", nixpkgs_version => '168115f610835654c1ed85a1bcf089f0919c9566', derivation => 'qf103qflq66phfni5xjzdw8dr4qlbpmw-emacs-24.3.drv', out => 'yng4dg2jwlvlmqg8k5x3ql1hd2wdzi5x-emacs-24.3');

1;
