package Packages::Emacs;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install_bin("emacs", nixpkgs_version => 'c9318f4d2d28d9716699c92280eccb4f12638aef', derivation => '70rvahr6g9nx4rrna2i97hwz8mxnwvlj-emacs-24.3.drv', out => '2riw11lk1pzfpnq41bagbng1hcbgxhya-emacs-24.3');

1;
