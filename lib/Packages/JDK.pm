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

$ENV{NIXPKGS_CONFIG}='/opt/ceh/lib/Packages/oraclejdk7ffmpegfix.nix';

if ($ENV{CEH_JAVA64}) {
    given ($ENV{CEH_JAVAFLAVOR}) {
        when ("sun6") {
            ceh_nixpkgs_install("oraclejdk", "/nix/var/nix/profiles/ceh/sun6-64", bit64 => 1, nixpkgs_version => '9a396b38405c951bc4f8a5aaebf5262789e2a325', out => '2sy4iw0fwxjw5zmn7xyi4hng24mld0ii-jdk-1.6.0_45b06');
        }
        when ("sun7") {
            ceh_nixpkgs_install("oraclejdk7", "/nix/var/nix/profiles/ceh/sun7-64", bit64 => 1, nixpkgs_version => '9a396b38405c951bc4f8a5aaebf5262789e2a325', out => 'gg03wjaqnzx5jxx11wmkqyk6hw2lycgm-jdk-1.7.0_51');
        }
        default {
            ceh_nixpkgs_install_bin64("openjdk", outFilter => sub { $_[0] !~ /-jre$/ }, nixpkgs_version => '9a396b38405c951bc4f8a5aaebf5262789e2a325', out => 'k0qpwy255ynqbi61g6s14ch5325dly9v-openjdk-7u40b43');
        }
    }
} else {
    given ($ENV{CEH_JAVAFLAVOR}) {
        when ("sun6") {
            ceh_nixpkgs_install("oraclejdk", "/nix/var/nix/profiles/ceh/sun6-32", nixpkgs_version => '9a396b38405c951bc4f8a5aaebf5262789e2a325', out => 'wvr54f56q20b9jm8lp37vav905p7vskn-jdk-1.6.0_45b06');
        }
        when ("sun7") {
            ceh_nixpkgs_install("oraclejdk7", "/nix/var/nix/profiles/ceh/sun7-32", nixpkgs_version => '9a396b38405c951bc4f8a5aaebf5262789e2a325', out => '5c8dknrydyx3gxml668zpvm0rdlzff6f-jdk-1.7.0_51');
        }
        default {
            ceh_nixpkgs_install_bin("openjdk", outFilter => sub { $_[0] !~ /-jre$/ }, nixpkgs_version => '9a396b38405c951bc4f8a5aaebf5262789e2a325', out => 'w8pajghksl5rg4y0474y3p9qw176nk8y-openjdk-7u40b43');
        }
    }
}

1;
