package Packages::VBootReference;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("vboot_reference", nixpkgs_version => 'c6261157f812eff0cdecc7cba3ee29be9224c4eb', out => 'rbx8v45kc3mh8jwxwn91r096540z70g7-vboot_reference-20130507');

1;
