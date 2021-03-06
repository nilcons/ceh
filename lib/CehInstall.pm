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
  check_nix_freshness
  ensure_base_installed
  $ceh_nix_install_root
  nix_symlink
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
# %autoinit: autocomplete the function invocation with default values,
#    Example: ceh_nixpkgs_install('git', AUTOINIT);
#      AUTOINIT will be replaced with correct values for
#      nixpkgs_version and out.
#    Example: ceh_nixpkgs_install('git', nixpkgs_version => '3abc135', AUTOINIT);
#      AUTOINIT will be replaced with correct value for out using
#      the specified nixpkgs git commit.
# %nixpkgs_version: nixpkgs version to use
# %out: output path in /nix/store, excludes AUTOINIT
# %gclink: full abspath of symlink location to protect against GC removal and facilitate caching
#          (defaults to /opt/ceh/installed/packages/$1)
# %set_nix_path: export NIX_PATH environment variable (before the build phase),
#   so that <nixpkgs> points to a checkout of %nixpkgs_version of nixpkgs
sub ceh_nixpkgs_install($%) {
    my ($pkgattr, %opts) = @_;
    my $autoinit = $opts{autoinit};
    my $autoupgrade = 0;
    my $nixsystem = "--option system x86_64-linux";
    my $nixpkgs_version = $opts{nixpkgs_version};
    my $out = $opts{out};
    my $old_nixpkgs_version = $opts{nixpkgs_version};
    my $old_out = $opts{out};
    my $autoinit_nixpkgs_version = 0;
    my $autoinit_out = 0;
    my $gclink = ($opts{gclink} ? $opts{gclink} : "/opt/ceh/installed/packages/$pkgattr");

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
    if ($out and nix_symlinked_p($gclink, $out)) {
        $ceh_nix_install_root = $gclink;
        return $ceh_nix_install_root;
    }

    my $nixpkgsgit = ceh_nixpkgs_checkout $nixpkgs_version;

    check_nix_freshness();

    my $cdevtmp = `$CEH_ESSNIXPATH/bin/nix-instantiate --show-trace $nixsystem $nixpkgsgit -A $pkgattr`;
    $? and confess("cdevtmp(" . $? . "): " . $cdevtmp);
    chomp($cdevtmp);
    $cdevtmp =~ /^\/nix\/store\// or croak($cdevtmp . " not starting with /nix/store");
    $cdevtmp =~ s,/nix/store/,,;
    $cdevtmp =~ s/!.*$//;
    my $current_derivation = $cdevtmp;

    # this hack is used by /opt/ceh/scripts/maintainer/predict-binary-cache.sh
    if ($ENV{CEH_GATHER_DERIVATIONS_ONLY}) {
        debug "CEH_GATHER_DERIVATIONS_ONLY: /nix/store/$current_derivation\n";
        exit 0;
    }
    my @outs = `$CEH_ESSNIXPATH/bin/nix-store -q /nix/store/$current_derivation`;
    $? and confess;
    foreach (@outs) {
        chomp;
        s,^/nix/store/,,;
    }
    if (scalar(@outs) == 0) {
        croak("nix-store -q didn't reply with output paths for derivation: $current_derivation");
    }
    my ($current_out, $outmap) = compute_outs_map(@outs);
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
    nix_symlink($gclink, $outmap);

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

    $ceh_nix_install_root = $gclink;
    return $ceh_nix_install_root;
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
    ceh_nixpkgs_install_essential('nix', nixpkgs_version => 'c29d2fde74d03178ed42655de6dee389f2b7d37f', out => 'vdvla43ppjf6gfsi8nx1zmac7rwq72yd-nix-2.0.2');
    ceh_nixpkgs_install_essential('perl', nixpkgs_version => 'c29d2fde74d03178ed42655de6dee389f2b7d37f', out => 'cxdmh98g0lvl1dyq304c1lq7f90dh01f-perl-5.24.3');
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

my $autoroot = "/nix/var/nix/gcroots/auto/ceh";
# Creates an indirect gc entry. (see nix-store(1))
# Since nix is multi output nowadays, for one derivation there are multiple outputs, e.g.:
#   $CEH_NIX/bin/nix-store -q /nix/store/c3rqkwb8yh7ph9sm9im3w8ay248sdb93-nix-1.11.2.drv
#   ->
#    /nix/store/3xx08z1wv87hx4rh04walcvrhw0jlrf5-nix-1.11.2
#    /nix/store/lw1g3ag6xr6mswrivr6ifj327fdmw7qr-nix-1.11.2-doc
#    /nix/store/m5m2gwhhzbyfdlmbf84hcdmjb9n78b1j-nix-1.11.2-debug
# Because of this, $1 is a directory, e.g. /opt/ceh/installed/essential/nix
# and we create inside this directory the following symlinks:
#    MAIN  -> /nix/store/3xx08z1wv87hx4rh04walcvrhw0jlrf5-nix-1.11.2
#    doc   -> /nix/store/lw1g3ag6xr6mswrivr6ifj327fdmw7qr-nix-1.11.2-doc
#    debug -> /nix/store/m5m2gwhhzbyfdlmbf84hcdmjb9n78b1j-nix-1.11.2-debug
sub replace_with_directory( $ ) {
    my $path = shift;
    if (-e $path || -l $path) {
        # Make way in case of both new and old /opt/ceh/installed standards
        rmtree($path) or croak("Can't delete $path");
    }
    make_path($path) or croak;
}

sub compute_outs_map(@) {
    my @outs = sort { length $a <=> length $b } @_; # map {"/nix/store/" . $_} @_;

    # Check that every line's non-hashed name has as a prefix the first line.
    my @names = @outs;
    map { s/^.*?-// } @names;
    my $basename = $names[0] . "-";
    shift @names;
    for (@names) {
        (substr ($_, 0, length($basename)) eq $basename)
            or croak("$basename is not a prefix of $_");
    }

    my %links;
    $links{"MAIN"} = $outs[0];
    my $baselen = length($outs[0]) + 1;
    shift @outs;
    for (@outs) {
        $links{substr($_, $baselen)} = $_;
    }

    return ($links{"MAIN"}, \%links);
}

sub nix_symlink($$) {
    my $gclinkbase = shift;
    my $autogclinkbase = "$autoroot$gclinkbase";
    my $links = shift;

    replace_with_directory($autogclinkbase);
    replace_with_directory($gclinkbase);

    while (my ($linkname, $storename) = each %{$links}) {
        systemdie("ln -s /nix/store/$storename $gclinkbase/$linkname");
        systemdie("ln -s $gclinkbase/$linkname $autogclinkbase/$linkname");
    }
}

# Verifies the existence of an entry created with nix_symlink
sub nix_symlinked_p($$) {
    my ($gclinkbase, $out) = @_;
    my $gclink = "$gclinkbase/MAIN";
    $out = "/nix/store/$out";
    my $autogclink = "$autoroot$gclink";
    my $o = readlink("$gclink");
    $o = "" if !defined($o);
    my $oo = readlink("$autogclink");
    $oo = "" if !defined($oo);
    return ($o eq "$out" && $oo eq "$gclink");
}

################################################################################
# Set up environmet variables which are not set to sensible values by
# Nix (except on NixOS :().

sub setenv($$;@) {
    my $var = shift;
    my $val = shift;
    # Don't set if it's already set
    return if (exists $ENV{$var});
    # Or if any of the alternatives are already set
    for my $v (@_) {
        return if (exists $ENV{$v});
    }

    $ENV{$var} = $val;
}

# Only do something if we are not on NixOS
if (! -e '/run/current-system') {
    if (-r '/usr/lib/locale/locale-archive') {
        setenv 'LOCALE_ARCHIVE', '/usr/lib/locale/locale-archive', 'LOCPATH';
    } else {
        setenv 'LOCPATH', '/usr/lib/locale', 'LOCALE_ARCHIVE';
    }

    setenv 'FONTCONFIG_FILE', '/etc/fonts/fonts.conf';
    setenv 'TZDIR', '/usr/share/zoneinfo';

    # Set up env vars for openssl
    # We only know how to do this on a Debian-like system
    if (-r '/etc/ssl/certs/ca-certificates.crt') {
        setenv 'SSL_CERT_DIR', '/etc/ssl/certs', 'SSL_CERT_FILE';
        setenv 'GIT_SSL_CAPATH', '/etc/ssl/certs';
        setenv 'CURL_CA_PATH', '/etc/ssl/certs';
    }
}

1;
