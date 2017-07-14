package Packages::EmacsNoGTK;

use strict;
use warnings;
use CehBase;
use CehInstall;

$ENV{NIXPKGS_CONFIG}="/opt/ceh/lib/Packages/emacs-nogtk.nix";

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("emacs25-nogtk", nixpkgs_version => '02a268430e13061aad441ec4a28579d46af79e33', out => '6wzhc29m6g379b9ckc3kzhb6igmibsay-emacs-25.2');

1;
