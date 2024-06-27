#!/usr/bin/perl

use strict;
use warnings;

my @cards = ('Visa', 'MasterCard', 'American Express', 'Discover', 'Maestro');
my @card_ocurrences = (111, 77, 98, 53, 109);

print "Array before sorting: @cards\n";
print "Array after sorting: ", sort @cards;
print "\n";
print "Array after sorting descending: ", reverse sort @cards;
print "\n";

print "===================\n";

print "Array before sorting: @card_ocurrences\n";
print "Array after sorting: ", sort { $a <=> $b } @card_ocurrences;
print "\n";
#too redundant
#print "Array after sorting descending: ", reverse sort { $a <=> $b } @card_ocurrences;
print "Array after sorting descending: ", sort { $b <=> $a } @card_ocurrences;
print "\n";

print "===================\n";

sub compare {
    if (length($a) < length($b)) {
        return -1;
    } elsif (length($a) == length($b)) {
        0;
    } else {
        return 1;
    }
}

print "Array before sorting: @cards\n";
print "Array after sorting: ", reverse sort compare @cards;
print "\n";
print "Array after sorting descending: ", reverse sort compare @cards;
print "\n"
