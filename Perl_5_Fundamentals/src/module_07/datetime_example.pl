#!usr/bin/perl
use strict;
use warnings;

require DateTime;

my $date = DateTime->now;
my $month = $date->month;

print "Current month: $month\n";