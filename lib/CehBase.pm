#!/opt/ceh/lib/perl

package CehBase;

use strict;
use warnings;
use File::Path qw(make_path rmtree);
use Carp;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($CEH_NIX $CEH_NIXPKGS_GITURL $CEH_NIXPKGS_GIT
  $CEH_BASELINE_NIXPKGS done debug touch systemdie path_prepend
  ensure_nix_installed_in_bin_profile);

our $CEH_NIX='/nix/store/k0ksg8yjwz026vwivcnkjwfmv4jbkqyl-nix-1.5.1';
our $CEH_NIXPKGS_GITURL='http://github.com/NixOS/nixpkgs';
our $CEH_NIXPKGS_GIT='/nix/var/ceh_nixpkgs';
our $CEH_BASELINE_NIXPKGS='b253eb0d593cb1041bd9c87ab03dbf72295c79d6';

sub done($) {
    return -f "$_[0].done";
}

sub debug {
    print STDERR @_, "\n";
}

sub touch($) {
    open my $fh, '>', "$_[0]" or croak;
    close $fh or croak;
}

sub systemdie {
    system(@_) == 0 or croak;
}

# Prepends $1 to the front of $2 (which should be a colon separated
# list).  If $1 is already contained in $2, deletes the old occurrence
# first.  $2 defaults to PATH.  No-op if $1 is not a directory.
sub path_prepend {
    use Env::Path;

    my ($new, $what) = @_;
    $what = 'PATH' unless $what;
    return unless -d "$new";
    my $path = Env::Path->$what;
    $path->Remove($new)->Prepend($new);
    $ENV{$what} = $$path;
}

sub ensure_nix_installed_in_bin_profile {
    # Don't call ceh_nixpkgs_install_bin, because that will try to install
    # a nix from nixpkgs, we simply want to load $CEH_NIX to the bin
    # profile (mainly for manpages).

    my $profile = "/nix/var/nix/profiles/ceh/bin";
    my $out = $CEH_NIX; $out =~ s,^/nix/store/,,;
    if (not -e "$profile/installed_derivations/$out") {
        systemdie("$CEH_NIX/bin/nix-env -p $profile -i $CEH_NIX >&2");
        ceh_nix_update_cache($profile);
    }
}

1;
