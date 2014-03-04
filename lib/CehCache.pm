#!/opt/ceh/lib/perl

package CehCache;

use strict;
use warnings;
use File::Basename qw(dirname);
use File::Path qw(make_path rmtree);
use Carp;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw(ceh_nix_update_cache);
use CehBase;

# This creates a cache to make it cheaper to check if an outpath is
# installed in a profile.  The idea is that profiles are immutable, so
# we can create an installed_derivations top-level dir in them with
# one file touched for each package.
#
# The installed_derivations directory should really be called
# installed_outputs.
#
# $1 is the profile path
sub ceh_nix_update_cache($) {
    my ($profile) = @_;

    return if done("$profile/installed_derivations");

    # If the profile doesn't exist, the cache can't be created.  It's
    # intentional that this is not an error, so we can call this
    # update function from anywhere even if the first package is just
    # being installed to a new profile.
    return unless -l $profile;

    chmod 0755, "$profile" or croak;
    rmtree("$profile/installed_derivations");
    not -e "$profile/installed_derivations" or croak;
    mkdir "$profile/installed_derivations" or croak;

    my @paths = `$CEH_ESSPATH/bin/nix-env -p $profile --no-name --out-path -q '*'`;
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
