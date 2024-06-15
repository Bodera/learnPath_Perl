#!usr/bin/perl
use strict;
use warnings;

use feature 'state';

sub print_footer {
    state $counter = 1;
    print "Footer line: $counter\n";
    $counter++;
}

for (1..5) {
    &print_footer;
}