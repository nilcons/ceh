package Replacer;

use strict;
use warnings;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw(replace_in_backtrace);

use CehBase;

sub try_replace($$$$) {
    my ($file, $line, $from, $to) = @_;

    local $^I   = '';
    local @ARGV = ( $file );
    my $succeeded = 0;
    while (<>) {
    	if (not $succeeded and $. >= $line and $. <= $line + 5) {
    	    if (s/$from/$to/) {
		$succeeded = 1;
	    }
    	}
    	print;
    }

    return $succeeded;
}

sub replace_in_backtrace($$) {
    my $from = shift;
    my $to = shift;

    for (my $i = 1;; ++$i) {
	my (undef, $file, $sor) = caller($i);
	last unless $file;
	if (try_replace($file, $sor, $from, $to)) {
	    return 1;
	}
    }
    return 0;
}

1;
