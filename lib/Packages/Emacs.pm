package Packages::Emacs;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("emacs", nixpkgs_version => 'f666bf4ddf3f5f50cad6e17907dae53d545444d0', out => '0nylryx8gl2whjcd29icsgxci217qrl5-emacs-24.3');

1;
