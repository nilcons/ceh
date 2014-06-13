package Packages::Emacs;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("emacs", nixpkgs_version => 'c6261157f812eff0cdecc7cba3ee29be9224c4eb', out => 'j4ljycmca880xsbln6jm4l19nsdp7ayh-emacs-24.3');

1;
