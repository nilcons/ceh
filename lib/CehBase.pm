#!/opt/ceh/lib/perl

package CehBase;

use strict;
use warnings;
use File::Path qw(make_path rmtree);
use Carp;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($CEH_ESSNIXPATH $CEH_ESSGCLINKDIR
  $CEH_NIXPKGS_GITURL $CEH_NIXPKGS_GIT
  $CEH_BASELINE_NIXPKGS $CEH_BASELINE_NIXPATH $CEH_BASELINE_PERL
  done debug touch systemdie path_prepend);

# The difference between CEH_ESSNIXPATH and CEH_ESSGCLINKDIR is that the
# latter is just a constant for the essential gc link dir, while
# CEH_ESSNIXPATH can be overridden to point to a directory that contains
# a working set of nix- binaries.  This feature is used in ceh-init.sh
# to handle NixOS and other distributions differently.
our $CEH_ESSGCLINKDIR='/opt/ceh/installed/essential';
our $CEH_ESSNIXPATH="$CEH_ESSGCLINKDIR/nix/MAIN";
our $CEH_NIXPKGS_GITURL='http://github.com/NixOS/nixpkgs';
our $CEH_NIXPKGS_GIT='/opt/ceh/nixpkgs';

our $CEH_BASELINE_NIXPKGS='c29d2fde74d03178ed42655de6dee389f2b7d37f';
our $CEH_BASELINE_NIXPATH='vdvla43ppjf6gfsi8nx1zmac7rwq72yd-nix-2.0.2';
our $CEH_BASELINE_PERL='cxdmh98g0lvl1dyq304c1lq7f90dh01f-perl-5.24.3';
# Don't forget to update emacs.d/nix-mode.el!

sub import {
    my $self = shift;
    my $first = shift;
    if (defined($first)) {
        if ($first eq "nixpath") {
            $CEH_ESSNIXPATH=shift;
        } else {
            unshift @_, $first;
        }
    }

    unshift @_, $self;
    -x "${CEH_ESSNIXPATH}/bin/nix-build" or die "*** Ceh is not initialized, run /opt/ceh/scripts/ceh-init.sh ${CEH_ESSNIXPATH}/bin/nix-build ***";
    goto &Exporter::import;
}

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

1;
