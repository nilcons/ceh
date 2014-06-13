package Packages::Git;

use strict;
use warnings;
use CehBase;
use CehInstall;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

ceh_nixpkgs_install("gitAndTools.gitFull", nixpkgs_version => 'c6261157f812eff0cdecc7cba3ee29be9224c4eb', out => '480ab6pkxq04ap61ijlw5d5z3n2igh18-git-1.9.4');

1;
