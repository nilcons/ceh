package Packages::Emacs;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install_bin("emacs", nixpkgs_version => '50f482288857f679acf10cd8a9b3f35a76466730', derivation => 'rgvzx19qb9swapilv51qf63iybdhkacm-emacs-24.3.drv', out => 'v4a5ccsb81cghadjyq2679mh5xyz1n8q-emacs-24.3');

1;
