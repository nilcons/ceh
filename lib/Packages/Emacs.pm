package Packages::Emacs;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("emacs", nixpkgs_version => '8392c8ba9f5eefbd13a0956b75f7253405135ec8', out => 'iqi3bfpck9f1sjg0a9qdwi93h3d4m0zw-emacs-24.3');

1;
