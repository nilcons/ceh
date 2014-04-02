package Packages::Emacs;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install_bin("emacs", nixpkgs_version => '9a396b38405c951bc4f8a5aaebf5262789e2a325', out => 'l83x2m2nhh3xn5jqfbjc21sf16sxih7y-emacs-24.3');

1;
