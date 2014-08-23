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
            ceh_nixpkgs_install("oraclejdk", bit64 => 1, nixpkgs_version => 'a38ae3c9367f9b5b2c4df437b97f3fcff294b9f7', out => 'm35fnqgv5ayzpcq8z756xd23lg1ja56w-jdk-1.6.0_45b06');
        }
        when ("sun7") {
            ceh_nixpkgs_install("oraclejdk7", bit64 => 1, nixpkgs_version => 'a38ae3c9367f9b5b2c4df437b97f3fcff294b9f7', out => 'zwv1lpjzix5w57jxz7cjac6bqz2ivg1b-oraclejdk-7u65');
        }
        default {
            ceh_nixpkgs_install("openjdk", outFilter => sub { $_[0] !~ /-jre$/ }, bit64 => 1, nixpkgs_version => 'a38ae3c9367f9b5b2c4df437b97f3fcff294b9f7', out => '3l9h8x85awyyx79pqm1y79xl53r6357l-openjdk-7u65b32');
        }
    }
} else {
    given ($ENV{CEH_JAVAFLAVOR}) {
        when ("sun6") {
            ceh_nixpkgs_install("oraclejdk", nixpkgs_version => 'a38ae3c9367f9b5b2c4df437b97f3fcff294b9f7', out => 'llq075857wz44qn04wsqymhivbg7xz2w-jdk-1.6.0_45b06');
        }
        when ("sun7") {
            ceh_nixpkgs_install("oraclejdk7", nixpkgs_version => 'a38ae3c9367f9b5b2c4df437b97f3fcff294b9f7', out => 'pd8bhylmx1q20m1q545l8qji8ybc730g-oraclejdk-7u65');
        }
        default {
            ceh_nixpkgs_install("openjdk", outFilter => sub { $_[0] !~ /-jre$/ }, nixpkgs_version => 'a38ae3c9367f9b5b2c4df437b97f3fcff294b9f7', out => 'n5bbzvf0i300f6zj9bgv0anrq475hi2f-openjdk-7u65b32');
        }
    }
}

1;
