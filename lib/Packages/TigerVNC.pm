package Packages::TigerVNC;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("tigervnc", nixpkgs_version => 'f666bf4ddf3f5f50cad6e17907dae53d545444d0', out => 'rs70109a790bwzg6dmjphylmv99jlpkw-tigervnc-r5129');

1;
