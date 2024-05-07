#!/usr/bin/perl

use strict;
use warnings;

my @cards = ("Visa", "MasterCard", "American Express", "Discover", "Maestro");

print "============Until loop==============\n";
my $index = 0;
until ($index > $#cards) {
    print "Actual card in index $index is @cards[$index].\n";
    ++$index;
}

print "============do..until loop==============\n";
$index = 0;
do {
    print "Actual card in index $index is @cards[$index].\n";
    ++$index;
} until ($index > $#cards);

print "============Next instruction and eq operator==============\n";
my @my_cards = ("Visa", "MasterCard", "Diners", "American Express", "Discover", "Maestro");
my $new_index = 0;

until ($new_index > $#my_cards) {
    if ($my_cards[$new_index] eq "Diners") {
        print "Skipping $my_cards[$new_index] card.\n";
        ++$new_index;
        next;
    }

    print "Actual card in index $new_index is @my_cards[$new_index].\n";
    ++$new_index;
}

print "============Last statement==============\n";
$new_index = 0;

until ($new_index > $#my_cards) {
    if ($my_cards[$new_index] eq "Diners") {
        print "Skipping $my_cards[$new_index] card.\n";
        last;
    }

    print "Actual card in index $new_index is @my_cards[$new_index].\n";
    ++$new_index;
}