#!/opt/ceh/lib/perl

package CehBase;

use strict;
use warnings;
use File::Path qw(make_path rmtree);
use Carp;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($CEH_ESSPATH $CEH_ESSPROFILE $CEH_BINPROFILE
  $CEH_NIXPKGS_GITURL $CEH_NIXPKGS_GIT
  $CEH_BASELINE_NIXPKGS $CEH_BASELINE_NIXPATH $CEH_BASELINE_PERL
  done debug touch systemdie path_prepend);

# The difference between CEH_ESSPATH and CEH_ESSPROFILE is that the
# latter is just a constant for the essential profile, while
# CEH_ESSPATH can be overridden to point to a directory that contains
# a working nix-env and perl binary.  This feature is used in
# ceh-init.sh to differentiate between NixOS and other distributions.
our $CEH_ESSPROFILE='/nix/var/nix/profiles/ceh/essential';
our $CEH_ESSPATH=$CEH_ESSPROFILE;
our $CEH_BINPROFILE='/nix/var/nix/profiles/ceh/bin';
our $CEH_NIXPKGS_GITURL='http://github.com/NixOS/nixpkgs';
our $CEH_NIXPKGS_GIT='/opt/ceh/nixpkgs';

our $CEH_BASELINE_NIXPKGS='8392c8ba9f5eefbd13a0956b75f7253405135ec8';
our $CEH_BASELINE_NIXPATH='g9nwwkg1l0y4jakzzph7xg0jbmg22hiz-nix-1.6.1';
our $CEH_BASELINE_PERL='b36q0vglgaxinmirvcgp525fqfdziia7-perl-5.16.3';
# Don't forget to update emacs.d/nix-mode.el!

sub import {
    my $self = shift;
    my $first = shift;
    if (defined($first)) {
        if ($first eq "nixpath") {
            $CEH_ESSPATH=shift;
        } else {
            unshift @_, $first;
        }
    }

    unshift @_, $self;
    -x "${CEH_ESSPATH}/bin/nix-env" or die "*** Ceh is not initialized, run /opt/ceh/scripts/ceh-init.sh ***";
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
