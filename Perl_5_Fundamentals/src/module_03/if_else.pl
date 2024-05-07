#!/usr/bin/perl

use strict;
use warnings;

my @cards = ('Visa', 'MasterCard', 'American Express', 'Discover', 'Maestro');
my $cards_size = @cards;

if ($cards_size < 5 && $cards_size > 0) {
    print "A few major credit cards will be checked in our log files.\n";

} elsif ($cards_size > 4) {
    print "Many major credit cards will be checked in our log files.\n";

} else {
    print "No major credit cards will be checked in our log files.\n";
}

print "=================unless====================\n";
$cards_size = 0;
unless ($cards_size > 0) {
    print "No major credit cards will be checked in our log files.\n";
}