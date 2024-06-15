#!usr/bin/perl

use strict;
use warnings;

my $card_brand = "Visa";
$$card_brand = "Mastercard";
# same as
# ${$card_brand} = "Mastercard";

print "Symbolic reference points to: $$card_brand\n";
print "Card Brand is: $card_brand\n";
#print "Created a new variable \"Visa\" with the value of: $Visa\n";