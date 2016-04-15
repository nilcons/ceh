package Packages::Emacs;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("emacs", nixpkgs_version => '551296a1cec0b9751ab96c420a7481e322ea127d', out => 'cmhjzgk3vn4s5zpyjp86cj577kvgfkn7-emacs-24.5');

1;
