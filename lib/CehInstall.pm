package CehInstall;

use strict;
use warnings;
use File::Basename qw(dirname);
use File::Path qw(make_path rmtree);
use Carp;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw(
  AUTOINIT
  ceh_nixpkgs_checkout
  ceh_nixpkgs_install
  ceh_nixpkgs_install_tools
  ceh_nixpkgs_install_ghclibs
  check_nix_freshness
  ensure_base_installed
  $ceh_nix_install_root
);


use CehBase;
use Replacer;

# So we don't accidentally use git from ceh and go into an infinite loop
our $git='git';

# Return variables
our $ceh_nix_install_root = '';

sub AUTOINIT() {
    return autoinit => "1";
}

# Creates a bare http://github.com/nixos/nixpkgs clone at
# $CEH_NIXPKGS_GIT/git.
sub ceh_nixpkgs_clone() {
    if (not done("$CEH_NIXPKGS_GIT/git")) {
        debug "Cloning the nixpkgs repository from github...";
        rmtree("$CEH_NIXPKGS_GIT/git");
        not -e "$CEH_NIXPKGS_GIT/git" or croak;
        make_path("$CEH_NIXPKGS_GIT/git") or croak;
        systemdie($git, qw(clone --bare), $CEH_NIXPKGS_GITURL, "$CEH_NIXPKGS_GIT/git");
        touch "$CEH_NIXPKGS_GIT/git.done";
    }
    debug "Updating the nixpkgs repository from github...";
    systemdie("cd $CEH_NIXPKGS_GIT/git && $git fetch origin master:master");
}

# Downloads and initializes a specific nixpkgs version into the
# $CEH_NIXPKGS_GIT/$1 directory, so it can be used for builds later.
#
# This is needed instead of simply using channels and the newest
# version only, because we want to reproduce specific blessed versions
# of binaries and not the newest version in nixpkgs.
#
# $1: the nixpkgs commit from https://github.com/NixOS/nixpkgs/commit
#
# It returns the path where the initialized checkout can be found.
sub ceh_nixpkgs_checkout($) {
    my $commit = shift;

    if (not done("$CEH_NIXPKGS_GIT/$commit")) {
        ceh_nixpkgs_clone();
        rmtree("$CEH_NIXPKGS_GIT/$commit");
        not -e "$CEH_NIXPKGS_GIT/$commit" or die;
        systemdie("$git", qw(clone -s -n), "$CEH_NIXPKGS_GIT/git", "$CEH_NIXPKGS_GIT/$commit");
        systemdie("cd $CEH_NIXPKGS_GIT/$commit && $git reset --hard $commit");
        touch("$CEH_NIXPKGS_GIT/$commit.done");
    }

    return "$CEH_NIXPKGS_GIT/$commit";
}

# Used in wrapper scripts in bin/*.
#
# If $1 is an already installed package, returns immediately.
# Otherwise builds and installs it.  In case of success, sets
# ceh_nix_install_root to /nix/store/outhash, so it's easy to refer to
# the binaries in the wrapper scripts.
#
# Nix itself uses a binary cache, so it may be not necessarily build.
#
# There are three ways to call this function:
#  - without AUTOINIT and providing all three package properties:
#    - pkgattr (the name of the package from ceh_nixpkgs_avail),
#    - the nixpkgs_version,
#    - the out path hash;
#  - with AUTOINIT and specifying two properties:
#    - specifying the pkgattr,
#    - specifying the nixpkgs_version,
#    - the out path hash will be autoguessed;
#  - with AUTOINIT and specifying one property:
#    - specifying the pkgattr,
#    - the nixpkgs_version will be the baseline,
#    - the out path hash will be autoguessed.
#
# In the latter two cases the autoguess results will be written back
# to the calling script by some Perl magic (Replacer.pm).  So on the
# second run, no autoguessing will be needed, because the call will be
# already rewritten to be in the first form.  If you want autoguessing
# continuously (while testing a nix expression), use 'autoinit => 1'
# instead of AUTOINIT.
#
# If the CEH_AUTO_UPGRADE envvar is set to 1, and all of the three
# arguments are specified, but the nixpkgs_version is outdated, then
# the package will be upgraded and the new nixpkgs_version, outhash
# will be written to the calling script.
#
# $1: package name (attribute path),
# %bit32: build/install for i686-linux if 1 (default is to install for x86_64-linux),
# %autoinit: autocomplete the function invocation with default values,
#    Example: ceh_nixpkgs_install('git', AUTOINIT);
#      AUTOINIT will be replaced with correct values for
#      nixpkgs_version and out.
#    Example: ceh_nixpkgs_install('git', nixpkgs_version => '3abc135', AUTOINIT);
#      AUTOINIT will be replaced with correct value for out using
#      the specified nixpkgs git commit.
# %nixpkgs_version: nixpkgs version to use
# %out: output path in /nix/store, excludes AUTOINIT
# %outFilter: filters outputs
# %gclink: full abspath of symlink location to protect against GC removal and facilitate caching
#          (defaults to /opt/ceh/installed/packages/$1)
#          a .32 suffix automatically gets appended if the bit32 parameter is on
# %set_nix_path: export NIX_PATH environment variable (before the build phase),
#   so that <nixpkgs> points to a checkout of %nixpkgs_version of nixpkgs
sub ceh_nixpkgs_install($%) {
    my ($pkgattr, %opts) = @_;
    my $autoinit = $opts{autoinit};
    my $autoupgrade = 0;
    my $nixsystem = $opts{bit32} ? "--option system i686-linux" : "--option system x86_64-linux";
    my $nixpkgs_version = $opts{nixpkgs_version};
    my $out = $opts{out};
    my $outFilter = $opts{outFilter};
    my $old_nixpkgs_version = $opts{nixpkgs_version};
    my $old_out = $opts{out};
    my $autoinit_nixpkgs_version = 0;
    my $autoinit_out = 0;
    my $gclink = ($opts{gclink} ? $opts{gclink} : "/opt/ceh/installed/packages/$pkgattr") .
                 ($opts{bit32} ? ".32" : "");

    # some sanity checks
    if (defined($opts{derivation})) {
        croak "Supplying derivation hash is not supported anymore";
    }
    if ($nixpkgs_version) {
        if ($autoinit) {
            croak "out supplied while AUTOINIT was enabled" if $out;
            $autoinit_out = 1;
            debug "Ceh auto init mode!\n";
        } else {
            croak "out is required, maybe wanted to use AUTOINIT?" if not $out;
        }
    } else {
        croak "no nixpkgs_version supplied, maybe you wanted to use AUTOINIT?" unless $autoinit;
        croak "out was provided while nixpkgs_version was not" if $out;
        $autoinit_nixpkgs_version = $autoinit_out = 1;
    }

    if ($ENV{CEH_AUTO_UPGRADE} and not $autoinit) {
        # if the baseline is so new that it's not currently fetched, fetch it
        `cd $CEH_NIXPKGS_GIT/git && $git rev-list --max-count=1 $CEH_BASELINE_NIXPKGS 2>/dev/null`;
        $? and ceh_nixpkgs_clone();
        my @revs = `cd $CEH_NIXPKGS_GIT/git && $git rev-list --max-count=1 $nixpkgs_version..$CEH_BASELINE_NIXPKGS`;
        $? and croak;
        if (@revs) {
            debug "Ceh auto upgrade mode!";
            $autoupgrade = 1;
            $out = "";
            $nixpkgs_version = "";
        }
    }

    # debug "pkgattr: $pkgattr";
    # debug "gclink: $gclink";
    # debug "autoinit: $autoinit" if $autoinit;
    # debug "autoupgrade: $autoupgrade";
    # debug "nixpkgs_version: $nixpkgs_version" if $nixpkgs_version;
    # debug "out: $out" if $out;

    if (not $nixpkgs_version) {
        $nixpkgs_version = $CEH_BASELINE_NIXPKGS;
        debug "*** Autoguessed nixpkgs version: $nixpkgs_version";
    }

    # Set the NIX_PATH env var if requested:
    if ($opts{set_nix_path}) {
        $ENV{NIX_PATH} = "nixpkgs=" . ceh_nixpkgs_checkout($nixpkgs_version);
    }

    # quick return if the package is already installed
    if ($out and nix_symlinked_p($gclink, "$out")) {
        $ceh_nix_install_root = "/nix/store/$out";
        return $ceh_nix_install_root;
    }

    # Change personality to match what we're building for
    if ($opts{bit32}) {
        syscall(136, 8);
    } else {
        syscall(136, 0);
    }

    my $nixpkgsgit = ceh_nixpkgs_checkout $nixpkgs_version;

    check_nix_freshness();

    my $cdevtmp = `$CEH_ESSNIXPATH/bin/nix-instantiate --show-trace $nixsystem $nixpkgsgit -A $pkgattr`;
    $? and confess;
    chomp($cdevtmp);
    $cdevtmp =~ /^\/nix\/store\// or croak($cdevtmp . " not starting with /nix/store");
    $cdevtmp =~ s,/nix/store/,,;
    my $current_derivation = $cdevtmp;

    # this hack is used by /opt/ceh/scripts/maintainer/predict-binary-cache.sh
    if ($ENV{CEH_GATHER_DERIVATIONS_ONLY}) {
        debug "CEH_GATHER_DERIVATIONS_ONLY: /nix/store/$current_derivation\n";
        exit 0;
    }
    my @outs = `$CEH_ESSNIXPATH/bin/nix-store -q /nix/store/$current_derivation`;
    $? and croak;
    foreach (@outs) {
        chomp;
        s,^/nix/store/,,;
    }
    if ($outFilter) {
        @outs = grep { &$outFilter($_) } @outs;
    }
    ($#outs == 0) or croak("nix-store -q didn't reply with exactly one out path, maybe use outFilter?");
    my $current_out = $outs[0];
    if (not $out) {
        $out = $current_out;
        debug "*** Autoguessed out: $out";
    }
    ($out eq $current_out) or croak("out mismatch.  expected: $out, deducted: $current_out");

    my $extraopts = "";
    $extraopts .= " --option use-binary-caches false" if ($ENV{CEH_NO_BIN_CACHE});
    $extraopts .= " --option build-max-jobs $ENV{CEH_BUILD_MAX_JOBS}" if ($ENV{CEH_BUILD_MAX_JOBS});
    $extraopts .= " -K" if ($ENV{CEH_BUILD_KEEP_FAILED});
    systemdie("$CEH_ESSNIXPATH/bin/nix-store $extraopts $nixsystem -r /nix/store/$current_derivation >&2");
    nix_symlink($gclink, "$out");

    if ($autoinit) {
        not $autoupgrade or croak("autoupgrade and autoinit at once?");
        debug "Doing autoinit!\n";
        replace_in_backtrace("AUTOINIT", qq{nixpkgs_version => '$nixpkgs_version', AUTOINIT}) if $autoinit_nixpkgs_version;
        replace_in_backtrace("AUTOINIT", qq{out => '$out'}) if $autoinit_out;
    }

    if ($autoupgrade) {
        not $autoinit or croak("autoupgrade and autoinit at once?");
        debug "Doing autoupgrade!\n";

        replace_in_backtrace("'$old_nixpkgs_version'", "'$nixpkgs_version'");
        replace_in_backtrace(qq{"$old_nixpkgs_version"}, qq{"$nixpkgs_version"});

        replace_in_backtrace("'$old_out'", "'$out'");
        replace_in_backtrace(qq{"$old_out"}, qq{"$out"});
    }

    $ceh_nix_install_root = "/nix/store/$out";
    return $ceh_nix_install_root;
}

# Libraries for GHC FFI packages.
sub ceh_nixpkgs_install_ghclibs {
    my ($pkgattr, %opts) = @_;
    return ceh_nixpkgs_install($pkgattr, gclink => "/opt/ceh/installed/ghclibs/$pkgattr", %opts);
}

# Use this when you're installing packages used internally by Ceh.
# E.g. the which package for ceh_exclude.
sub ceh_nixpkgs_install_tools {
    my ($pkgattr, %opts) = @_;
    return ceh_nixpkgs_install($pkgattr, gclink => "/opt/ceh/installed/tools/$pkgattr", %opts);
}

sub ceh_nixpkgs_install_essential {
    my ($pkgattr, %opts) = @_;
    return ceh_nixpkgs_install($pkgattr, gclink => "$CEH_ESSGCLINKDIR/$pkgattr", %opts);
}

sub ensure_base_installed {
    ceh_nixpkgs_install_essential('nix', bit32 => 1, nixpkgs_version => '3d74b3810104878527f0fde8aad65908579a504e', out => 'i22jh334x91k0lbrmyxxymvd1ym7vysd-nix-1.8');
    ceh_nixpkgs_install_essential('perl', bit32 => 1, nixpkgs_version => '3d74b3810104878527f0fde8aad65908579a504e', out => 'p0kbl09j5q88d9i96ap4arffsd5ybjwx-perl-5.20.1');
}

our $freshness_being_ensured;
sub check_nix_freshness {
    return if ($freshness_being_ensured);
    if (not nix_symlinked_p("$CEH_ESSGCLINKDIR/nix", "$CEH_BASELINE_NIXPATH") or
        not nix_symlinked_p("$CEH_ESSGCLINKDIR/perl", "$CEH_BASELINE_PERL")) {
        debug "Nix or Perl is outdated in the essential Ceh directory, let's reinstall them!";
        debug "If this fails, please run /opt/ceh/scripts/ceh-init.sh!\n";
        local $freshness_being_ensured = 1;
        ensure_base_installed();
    }
}

sub ensure_dir_of_path {
    my ($dir) = @_;
    if (not -d dirname($dir)) {
        make_path(dirname($dir)) or confess;
    }
}

my $autoroot = "/nix/var/nix/gcroots/auto/ceh";
# Creates an indirect gc entry. (see nix-store(1))
sub nix_symlink($$) {
    my ($gclink, $out) = @_;
    $out = "/nix/store/$out";
    my $autogclink = "$autoroot$gclink";
    ensure_dir_of_path($gclink);
    ensure_dir_of_path($autogclink);
    systemdie("ln -sfn $out $gclink >&2");
    systemdie("ln -sfn $gclink $autogclink >&2");
}

# Verifies the existence of an entry created with nix_symlink
sub nix_symlinked_p($$) {
    my ($gclink, $out) = @_;
    $out = "/nix/store/$out";
    my $autogclink = "$autoroot$gclink";
    my $o = readlink("$gclink");
    $o = "" if !defined($o);
    my $oo = readlink("$autogclink");
    $oo = "" if !defined($oo);
    return ($o eq "$out" && $oo eq "$gclink");
}

1;
