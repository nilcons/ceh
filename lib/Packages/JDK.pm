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
            ceh_nixpkgs_install("oraclejdk", bit64 => 1, nixpkgs_version => '0852d9e3643458ebd435b366bb3ecd79b0f47400', out => 'vxnanazqz6c3c5m94vmcpwic7gx1dkwa-jdk-1.6.0_45b06');
        }
        when ("sun7") {
            ceh_nixpkgs_install("oraclejdk7", bit64 => 1, nixpkgs_version => '0852d9e3643458ebd435b366bb3ecd79b0f47400', out => '2a9qd34prl1h1wyycj52lgydy4zya038-oraclejdk-7u65');
        }
        default {
            ceh_nixpkgs_install("openjdk", outFilter => sub { $_[0] !~ /-jre$/ }, bit64 => 1, nixpkgs_version => '0852d9e3643458ebd435b366bb3ecd79b0f47400', out => '4pm936j6ql3njzfbv56gv7jg6fx08xzj-openjdk-7u65b32');
        }
    }
} else {
    given ($ENV{CEH_JAVAFLAVOR}) {
        when ("sun6") {
            ceh_nixpkgs_install("oraclejdk", nixpkgs_version => '0852d9e3643458ebd435b366bb3ecd79b0f47400', out => '10vhn9f1c0myv4xnlz2byzgs5gvl0iqw-jdk-1.6.0_45b06');
        }
        when ("sun7") {
            ceh_nixpkgs_install("oraclejdk7", nixpkgs_version => '0852d9e3643458ebd435b366bb3ecd79b0f47400', out => '7sylk7gm552gpgyxr3sgaw10awan0qz3-oraclejdk-7u65');
        }
        default {
            ceh_nixpkgs_install("openjdk", outFilter => sub { $_[0] !~ /-jre$/ }, nixpkgs_version => '0852d9e3643458ebd435b366bb3ecd79b0f47400', out => 'fhhncm8y9924dsf913xgqxnms6ckakr2-openjdk-7u65b32');
        }
    }
}

1;
