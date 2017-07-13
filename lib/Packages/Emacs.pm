package Packages::Emacs;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("emacs", nixpkgs_version => '02a268430e13061aad441ec4a28579d46af79e33', out => '9a6y5cwg4sfzn9qq34zhh2ikb610di3h-emacs-25.2');

1;
