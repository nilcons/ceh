#!/opt/ceh/lib/perl
# -*- mode: perl; -*-

# See README.compile-ghc-with-ceh

use strict;
use warnings;
use lib "/opt/ceh/lib";
use CehBase;
use CehInstall;
use Packages::GHC;

sub ceh_nixpkgs_install_ghcbuildbin {
    my ($pkgattr, %opts) = @_;
    return ceh_nixpkgs_install($pkgattr, "/nix/var/nix/profiles/ceh/ghc-build-bin", %opts);
}

sub ceh_nixpkgs_install_ghcbuildbin64 {
    my ($pkgattr, %opts) = @_;
    return ceh_nixpkgs_install($pkgattr, "/nix/var/nix/profiles/ceh/ghc-build-bin64", bit64 => 1, %opts);
}

sub ceh_nixpkgs_install_ghcbuildbin_binutils {
    my ($pkgattr, %opts) = @_;
    return ceh_nixpkgs_install($pkgattr, "/nix/var/nix/profiles/ceh/ghc-build-binutils", %opts);
}

sub ceh_nixpkgs_install_ghcbuildbin_binutils64 {
    my ($pkgattr, %opts) = @_;
    return ceh_nixpkgs_install($pkgattr, "/nix/var/nix/profiles/ceh/ghc-build-binutils64", bit64 => 1, %opts);
}

ceh_nixpkgs_install_ghcbuildbin("perl", nixpkgs_version => '8392c8ba9f5eefbd13a0956b75f7253405135ec8', out => 'b36q0vglgaxinmirvcgp525fqfdziia7-perl-5.16.3');
ceh_nixpkgs_install_ghcbuildbin("gnumake", nixpkgs_version => '8392c8ba9f5eefbd13a0956b75f7253405135ec8', out => 'qydkavsi74vrdifqdg1cmd3099w5jxdx-gnumake-3.82');
ceh_nixpkgs_install_ghcbuildbin("m4", nixpkgs_version => '8392c8ba9f5eefbd13a0956b75f7253405135ec8', out => 'sy5g0lwiijnl5qwbkvnphsih9hcx7cv7-gnum4-1.4.17');
ceh_nixpkgs_install_ghcbuildbin("autoconf", nixpkgs_version => '8392c8ba9f5eefbd13a0956b75f7253405135ec8', out => 'xk91ni9k12rdxbxd99nk371dhl1ilj6c-autoconf-2.69');
ceh_nixpkgs_install_ghcbuildbin("automake", nixpkgs_version => '8392c8ba9f5eefbd13a0956b75f7253405135ec8', out => 'ncpn642m572ikhmfxfz0siszmhwral6f-automake-1.12.6');
path_prepend("/nix/var/nix/profiles/ceh/ghc-build-bin/bin");

if ($ENV{CEH_GHC64}) {
    ceh_nixpkgs_install_ghcbuildbin_binutils64("binutils", nixpkgs_version => '8392c8ba9f5eefbd13a0956b75f7253405135ec8', out => 'zavr44hpdr317c2szv6zypwlwpn9fhsw-binutils-2.23.1');
    path_prepend("/nix/var/nix/profiles/ceh/ghc-build-binutils64/bin");
} else {
    ceh_nixpkgs_install_ghcbuildbin_binutils("binutils", nixpkgs_version => '8392c8ba9f5eefbd13a0956b75f7253405135ec8', out => 'hznwicmjriqd73cq2lbcpv74ybhgmsdv-binutils-2.23.1');
    path_prepend("/nix/var/nix/profiles/ceh/ghc-build-binutils/bin");
}

# TODO(errge): once todo in GHC.pm completed, this can use that infrastructure.
my $outncurses;
my $outgmp;
if ($ENV{CEH_GHC64}) {
    $outncurses = ceh_nixpkgs_install_ghcbuildbin64('ncurses', nixpkgs_version => '8392c8ba9f5eefbd13a0956b75f7253405135ec8', out => '4h0qnywpw5m817xasgi8hczy03vgx00r-ncurses-5.9');
    $outgmp = ceh_nixpkgs_install_ghcbuildbin64('gmp', nixpkgs_version => '8392c8ba9f5eefbd13a0956b75f7253405135ec8', out => 'xjm0rglwknhwnrvb9xv9kszcz7b8vnp4-gmp-5.1.3');
} else {
    $outncurses = ceh_nixpkgs_install_ghcbuildbin('ncurses', nixpkgs_version => '8392c8ba9f5eefbd13a0956b75f7253405135ec8', out => 'fzbdzmii8sa5rqfwbg9gcfrdir0vbci6-ncurses-5.9');
    $outgmp = ceh_nixpkgs_install_ghcbuildbin('gmp', nixpkgs_version => '8392c8ba9f5eefbd13a0956b75f7253405135ec8', out => 'aa0zvp6nxkcklw0sk6dr5hjdxig6wy55-gmp-5.1.3');
}
$ENV{NIX_LDFLAGS}="-L $outncurses/lib";
$ENV{NIX_CFLAGS_COMPILE}="-idirafter $outncurses/include -idirafter $outgmp/include";

exec "bash", @ARGV;
