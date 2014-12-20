package Packages::JDK;

use strict;
use warnings;
use CehBase;
use CehInstall;
use feature qw(switch);

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($ceh_nix_install_root);

# (while (re-search-forward "nixpkgs_version =>" nil t) (backward-word 2) (kill-line) (insert "AUTOINIT);"))

$ENV{NIXPKGS_CONFIG}='/opt/ceh/lib/Packages/allownonfree.nix';

if (defined($ENV{CEH_JAVAFLAVOR}) && $ENV{CEH_JAVAFLAVOR} eq "sun6") {
    ceh_nixpkgs_install("oraclejdk", nixpkgs_version => '3d74b3810104878527f0fde8aad65908579a504e', out => 'vhr6x1vikz78as5q6lpb7rvrvhy5j0pk-jdk-1.6.0_45b06');
} elsif (defined($ENV{CEH_JAVAFLAVOR}) && $ENV{CEH_JAVAFLAVOR} eq "sun7") {
    ceh_nixpkgs_install("oraclejdk7", nixpkgs_version => '3d74b3810104878527f0fde8aad65908579a504e', out => 'zj25y6rnkxfx7lari9yw26xf1s9srym5-oraclejdk-7u71');
} else {
    ceh_nixpkgs_install("openjdk", outFilter => sub { $_[0] !~ /-jre$/ }, nixpkgs_version => '3d74b3810104878527f0fde8aad65908579a504e', out => 'kpwksji84sid7ns423qpxld9gi7c36rr-openjdk-7u65b32');
}

1;
