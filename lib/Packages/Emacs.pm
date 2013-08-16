package Packages::Emacs;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install_bin("emacs", nixpkgs_version => '1f2ecd08cc28d0d199d7f0304da9d8bbc2ff6239', derivation => 'jc1lp6c1f6lzj418vjaxwxgiysw91a3b-emacs-24.3.drv', out => '75dk4ih00cfl2ph51gs4i120kd35h719-emacs-24.3');

1;
