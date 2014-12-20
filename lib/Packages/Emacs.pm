package Packages::Emacs;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("emacs", nixpkgs_version => '3d74b3810104878527f0fde8aad65908579a504e', out => 'm2z4p6x2yb3ncf1v948m32c8w7q3pyyf-emacs-24.4');

1;
