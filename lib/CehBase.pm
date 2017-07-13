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
our $CEH_ESSNIXPATH="$CEH_ESSGCLINKDIR/nix.32/MAIN";
our $CEH_NIXPKGS_GITURL='http://github.com/NixOS/nixpkgs';
our $CEH_NIXPKGS_GIT='/opt/ceh/nixpkgs';

our $CEH_BASELINE_NIXPKGS='02a268430e13061aad441ec4a28579d46af79e33';
our $CEH_BASELINE_NIXPATH='nyf9vjh8lc3fl43byf6b86hq9bp3my9z-nix-1.11.11';
our $CEH_BASELINE_PERL='m82raw2hwbgxfxy4b6v9fckj9dxw23q4-perl-5.24.1';
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
