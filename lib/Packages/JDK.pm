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
            ceh_nixpkgs_install("oraclejdk", bit64 => 1, nixpkgs_version => 'f666bf4ddf3f5f50cad6e17907dae53d545444d0', out => 'wsxk9f74zf204s0lgygn2aiac32z4crn-jdk-1.6.0_45b06');
        }
        when ("sun7") {
            ceh_nixpkgs_install("oraclejdk7", bit64 => 1, nixpkgs_version => 'f666bf4ddf3f5f50cad6e17907dae53d545444d0', out => 'aq3f48v0ahb17vikn3k2vbzdyqamb8cn-jdk-1.7.0_60');
        }
        default {
            ceh_nixpkgs_install("openjdk", outFilter => sub { $_[0] !~ /-jre$/ }, bit64 => 1, nixpkgs_version => 'f666bf4ddf3f5f50cad6e17907dae53d545444d0', out => 'va47x0fr5mq7mh8pgy553ip3x4g16z7z-openjdk-7u40b43');
        }
    }
} else {
    given ($ENV{CEH_JAVAFLAVOR}) {
        when ("sun6") {
            ceh_nixpkgs_install("oraclejdk", nixpkgs_version => 'f666bf4ddf3f5f50cad6e17907dae53d545444d0', out => 'm43iq5289wbwag78y45r39fnz949ida4-jdk-1.6.0_45b06');
        }
        when ("sun7") {
            ceh_nixpkgs_install("oraclejdk7", nixpkgs_version => 'f666bf4ddf3f5f50cad6e17907dae53d545444d0', out => 'bmh0g9h7ashhrjlca4c33smlf68x4zqq-jdk-1.7.0_60');
        }
        default {
            ceh_nixpkgs_install("openjdk", outFilter => sub { $_[0] !~ /-jre$/ }, nixpkgs_version => 'f666bf4ddf3f5f50cad6e17907dae53d545444d0', out => 'iwqpizbchcq11ywrd55vvd9h3mqg8jb2-openjdk-7u40b43');
        }
    }
}

1;
