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

if ($ENV{CEH_JAVA64}) {
    given ($ENV{CEH_JAVAFLAVOR}) {
        when ("sun6") {
            ceh_nixpkgs_install("oraclejdk", "/nix/var/nix/profiles/ceh/sun6-64", bit64 => 1, nixpkgs_version => 'db12d783ffd753145119c22a34ca5945e9a7a4ce', derivation => 'rmdqa4kq2n16536xm2xqagqa1md1wwdx-jdk-1.6.0_45b06.drv', out => '6vhzv5fdjbh78hia0avrp1pcrfl2nlfx-jdk-1.6.0_45b06');
        }
        when ("sun7") {
            ceh_nixpkgs_install("oraclejdk7", "/nix/var/nix/profiles/ceh/sun7-64", bit64 => 1, nixpkgs_version => 'db12d783ffd753145119c22a34ca5945e9a7a4ce', derivation => 'ih4808c3xg77fh3l34bb1fy22p2g8hyz-jdk-1.7.0_51.drv', out => 'j76gxknaa51whmk27cm9akx0azx1aq8m-jdk-1.7.0_51');
        }
        default {
            ceh_nixpkgs_install_bin64("openjdk", outFilter => sub { $_[0] !~ /-jre$/ }, nixpkgs_version => 'db12d783ffd753145119c22a34ca5945e9a7a4ce', derivation => 'mrx4zj12p010vr02k9gm9a0q749zq4ys-openjdk-7u40b43.drv', out => '91phdk90gkxbvnl5hfqs4517skjs8mrn-openjdk-7u40b43');
        }
    }
} else {
    given ($ENV{CEH_JAVAFLAVOR}) {
        when ("sun6") {
            ceh_nixpkgs_install("oraclejdk", "/nix/var/nix/profiles/ceh/sun6-32", nixpkgs_version => 'db12d783ffd753145119c22a34ca5945e9a7a4ce', derivation => '6ci1a2vkgxhqamcfrhfglpv51pzm0j11-jdk-1.6.0_45b06.drv', out => '9bx7f41dz0wgb8dvinqrk0j8gb59p0bs-jdk-1.6.0_45b06');
        }
        when ("sun7") {
            ceh_nixpkgs_install("oraclejdk7", "/nix/var/nix/profiles/ceh/sun7-32", nixpkgs_version => 'db12d783ffd753145119c22a34ca5945e9a7a4ce', derivation => '13l801il7j7wbw6730r0hs6rg3l7hq81-jdk-1.7.0_51.drv', out => 'aamik6j6bizgy0d1r6jd63cdd5nm3wg0-jdk-1.7.0_51');
        }
        default {
            ceh_nixpkgs_install_bin("openjdk", outFilter => sub { $_[0] !~ /-jre$/ }, nixpkgs_version => 'db12d783ffd753145119c22a34ca5945e9a7a4ce', derivation => 'npdwwwl9bnf4nks7f3r499dvml5vqvyw-openjdk-7u40b43.drv', out => 'r1fa3yh2gjhp65lq1rsvshr4rmg8m1k9-openjdk-7u40b43');
        }
    }
}

1;
