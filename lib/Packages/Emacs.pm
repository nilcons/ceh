package Packages::Emacs;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("emacs", nixpkgs_version => 'e07ea5cf77601325b16f51fb457b90d5aadfab6f', out => '7ajid5i7qs79y237gl4q5cg4pzmd328n-emacs-24.4');

1;
