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
            ceh_nixpkgs_install("oraclejdk", bit64 => 1, nixpkgs_version => 'c6261157f812eff0cdecc7cba3ee29be9224c4eb', out => '8x7rfs2q54cfxlz5ybqdw4sn6f962qv8-jdk-1.6.0_45b06');
        }
        when ("sun7") {
            ceh_nixpkgs_install("oraclejdk7", bit64 => 1, nixpkgs_version => 'c6261157f812eff0cdecc7cba3ee29be9224c4eb', out => '4z5bbskqwqqz94397v4g7563hqlqscq5-jdk-1.7.0_55');
        }
        default {
            ceh_nixpkgs_install("openjdk", outFilter => sub { $_[0] !~ /-jre$/ }, bit64 => 1, nixpkgs_version => 'c6261157f812eff0cdecc7cba3ee29be9224c4eb', out => 'vi4cncqhf910gd88hk7w9v80fjgma3r3-openjdk-7u40b43');
        }
    }
} else {
    given ($ENV{CEH_JAVAFLAVOR}) {
        when ("sun6") {
            ceh_nixpkgs_install("oraclejdk", nixpkgs_version => 'c6261157f812eff0cdecc7cba3ee29be9224c4eb', out => '28ksmyz415n0lyybxard8lsh3fay5n32-jdk-1.6.0_45b06');
        }
        when ("sun7") {
            ceh_nixpkgs_install("oraclejdk7", nixpkgs_version => 'c6261157f812eff0cdecc7cba3ee29be9224c4eb', out => '8km7cw0qfmbsm90dg7gg14w5hpgxg9kc-jdk-1.7.0_55');
        }
        default {
            ceh_nixpkgs_install("openjdk", outFilter => sub { $_[0] !~ /-jre$/ }, nixpkgs_version => 'c6261157f812eff0cdecc7cba3ee29be9224c4eb', out => '56a826fczqcbslb27vg7z661lkclhwvg-openjdk-7u40b43');
        }
    }
}

1;
