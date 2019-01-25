package Packages::EmacsNoGTK;

use strict;
use warnings;
use CehBase;
use CehInstall;

$ENV{NIXPKGS_CONFIG}="/opt/ceh/lib/Packages/emacs-nogtk.nix";

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("emacs25-nogtk", nixpkgs_version => 'c29d2fde74d03178ed42655de6dee389f2b7d37f', out => 'k00l02dbwfbv35wpxvs1wq2z7wl78r48-emacs-25.3');

1;
