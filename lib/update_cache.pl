#!/opt/ceh/lib/perl

use strict;
use warnings;
use lib '/opt/ceh/lib';
use Cache;
use Carp;

$ARGV[0] or croak("have to pass a profile as the first parameter");
ceh_nix_update_cache($ARGV[0]);
