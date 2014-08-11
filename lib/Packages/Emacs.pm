package Packages::Emacs;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("emacs", nixpkgs_version => '0852d9e3643458ebd435b366bb3ecd79b0f47400', out => 'jvda9lybbp3daagph5axxpw0wp8yp2rn-emacs-24.3');

1;
