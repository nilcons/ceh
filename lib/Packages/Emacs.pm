package Packages::Emacs;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("emacs", nixpkgs_version => '25777d2aca0221beb67311085f24698d401af080', derivation => 'sdf1h621s3rgrd325lwmc3kcqj7v54i8-emacs-24.3.drv', out => 'f19ryqqar02bd83dk6zcsa5ywg3yb1yr-emacs-24.3');

1;
