#!/opt/ceh/lib/perl

package Cache;

use strict;
use warnings;
use File::Path qw(make_path rmtree);
use Carp;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw(ceh_nix_update_cache);

use CehBase;

# This creates a cache to make it cheaper to check if a derivation is
# installed in a profile.  The idea is that profiles are immutable, so
# we can create an installed_derivations top-level dir in them with
# one file touched for each package.
#
# $1 is the profile path (defaults to /opt/ceh/home/.nix-profile).
sub ceh_nix_update_cache {
    my ($profile) = @_;
    my @profile = $profile ? ('-p', $profile) : ();
    $profile = "/opt/ceh/home/.nix-profile" if not $profile;

    return if done("$profile/installed_derivations");

    # If the profile doesn't exist, the cache can't be created.  It's
    # intentional that this is not an error, so we can call this
    # update function from anywhere even if the first package is just
    # being installed to a new profile.
    return unless -l $profile;
    if ($profile eq "/opt/ceh/home/.nix-profile") {
	return unless -l (readlink "/opt/ceh/home/.nix-profile");
    }

    chmod 0755, "$profile" or croak;
    rmtree("$profile/installed_derivations");
    not -e "$profile/installed_derivations" or croak;
    mkdir "$profile/installed_derivations" or croak;

    my @paths = `$CEH_NIX/bin/nix-env @profile --no-name --out-path -q '*'`;
    $? and croak;
    foreach (@paths) {
	chomp;
	s|/nix/store/||g;
	touch("$profile/installed_derivations/$_");
    }
    touch "$profile/installed_derivations.done";
    touch "$profile/installed_derivations/done"; # for compatibility with v1
    chmod 0555, $profile or croak;
}

1;
