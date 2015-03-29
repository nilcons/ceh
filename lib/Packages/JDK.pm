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
    ceh_nixpkgs_install("oraclejdk", nixpkgs_version => 'e07ea5cf77601325b16f51fb457b90d5aadfab6f', out => 'bhp8gxjif2b0vk56887f56a9ci9sdvfd-jdk-1.6.0_45b06');
} elsif (defined($ENV{CEH_JAVAFLAVOR}) && $ENV{CEH_JAVAFLAVOR} eq "sun7") {
    ceh_nixpkgs_install("oraclejdk7", nixpkgs_version => 'e07ea5cf77601325b16f51fb457b90d5aadfab6f', out => '4w8nnhkhr16han43saik611avxqh03fi-oraclejdk-7u75');
} elsif (defined($ENV{CEH_JAVAFLAVOR}) && $ENV{CEH_JAVAFLAVOR} eq "sun8") {
    ceh_nixpkgs_install("oraclejdk8", nixpkgs_version => 'e07ea5cf77601325b16f51fb457b90d5aadfab6f', out => '9vfnw4nl4x0imxrkpznwzkjwfpbvwm6d-oraclejdk-8u40');
} else {
    ceh_nixpkgs_install("openjdk", outFilter => sub { $_[0] !~ /-jre$/ }, nixpkgs_version => 'e07ea5cf77601325b16f51fb457b90d5aadfab6f', out => 'qjr6s6fm2vpfkgdh5iksg2zx23xf56hm-openjdk-7u65b32');
}

1;
