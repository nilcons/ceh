package Packages::Emacs;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install_bin("emacs", nixpkgs_version => 'b253eb0d593cb1041bd9c87ab03dbf72295c79d6', derivation => 's8v45yg0frvh2x8laixp9ak411ar69v6-emacs-24.3.drv', out => '3l0w5vfq06q50hmy6vmnpwja7dvifhn6-emacs-24.3');

1;
