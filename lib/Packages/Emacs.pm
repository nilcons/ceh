package Packages::Emacs;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install_bin("emacs", nixpkgs_version => 'e26b828f4a3f00c89497913970ca2fef8441367f', derivation => '5xp8fkyxp5lbc27y8w9hs09jlf52yc05-emacs-24.3.drv', out => 's1pyhrm0xswnny5cciawzb7kwmqvchyv-emacs-24.3');

1;
