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

if ($ENV{CEH_JAVA64}) {
    given ($ENV{CEH_JAVAFLAVOR}) {
        when ("sun6") {
            ceh_nixpkgs_install("oraclejdk", bit64 => 1, nixpkgs_version => '8392c8ba9f5eefbd13a0956b75f7253405135ec8', out => 'j360icgvf0cki7xxll46nmbbpwp5jvff-jdk-1.6.0_45b06');
        }
        when ("sun7") {
            ceh_nixpkgs_install("oraclejdk7", bit64 => 1, nixpkgs_version => '8392c8ba9f5eefbd13a0956b75f7253405135ec8', out => 'hvww6g5a4d04fnphyv5241rviwdk6nzr-jdk-1.7.0_51');
        }
        default {
            ceh_nixpkgs_install("openjdk", outFilter => sub { $_[0] !~ /-jre$/ }, bit64 => 1, nixpkgs_version => '8392c8ba9f5eefbd13a0956b75f7253405135ec8', out => '3v7m7k0cb0n5xphbx2m17wm04scr66rf-openjdk-7u40b43');
        }
    }
} else {
    given ($ENV{CEH_JAVAFLAVOR}) {
        when ("sun6") {
            ceh_nixpkgs_install("oraclejdk", nixpkgs_version => '8392c8ba9f5eefbd13a0956b75f7253405135ec8', out => '36bhv4z424xbqa4zp31b52hlgd5xywr0-jdk-1.6.0_45b06');
        }
        when ("sun7") {
            ceh_nixpkgs_install("oraclejdk7", nixpkgs_version => '8392c8ba9f5eefbd13a0956b75f7253405135ec8', out => 'jbmj9d6s83gn7jkg17m29rzik4dinx3z-jdk-1.7.0_51');
        }
        default {
            ceh_nixpkgs_install("openjdk", outFilter => sub { $_[0] !~ /-jre$/ }, nixpkgs_version => '8392c8ba9f5eefbd13a0956b75f7253405135ec8', out => 'p4z42n86ni6nsffg1dbaa1dmi742rqxp-openjdk-7u40b43');
        }
    }
}

1;
