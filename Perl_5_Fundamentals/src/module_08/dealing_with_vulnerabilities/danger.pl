#!/usr/bin/perl

use strict;
use warnings;

my $input = $ARGV[0];

print "Input: $input\n";
open (my $fh, $input) or die $!;

while (<$fh>) {
    print $_;
}

close $fh;
