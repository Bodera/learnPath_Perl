#!/usr/bin/perl

use strict;
use warnings;

my @cards = ("Visa", "MasterCard", "American Express", "Discover", "Maestro");

print "============While loop==============\n";
# Using the perl special variable $# (returns the highest index of the array)
my $index = 0;
while ($index <= $#cards) {
# this line is tricky. It will cause an infinite loop. 
# while (my $number <= $#numbers) {
    print "Actual card in index $index is @cards[$index].\n";
    ++$index;
}


print "============Do while loop==============\n";
print "the value of counter at the end of the loop is $index.\n";
do {
    print "This will be printed at least once.\n";
} while ($index <= $#cards);


print "============Next instruction and eq operator==============\n";
my @my_cards = ("Visa", "MasterCard", "Diners", "American Express", "Discover", "Maestro");
my $new_index = 0;

while ($new_index <= $#my_cards) {
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

while ($new_index <= $#my_cards) {
    if ($my_cards[$new_index] eq "Diners") {
        print "Skipping $my_cards[$new_index] card.\n";
        last;
    }

    print "Actual card in index $new_index is @my_cards[$new_index].\n";
    ++$new_index;
}
