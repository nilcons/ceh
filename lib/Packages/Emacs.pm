package Packages::Emacs;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install_bin("emacs", nixpkgs_version => 'ba4461f96f14b322ebd03d9cbcf4e0fdc206d595', derivation => 'j4ly1k9cpqsf2vq5vw86nikh4l5x0f7a-emacs-24.3.drv', out => '1zwhxrzr63z4d4xmdj42wp5llflwr6va-emacs-24.3');

1;
