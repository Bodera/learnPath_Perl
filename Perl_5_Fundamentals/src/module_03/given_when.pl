#!/usr/bin/perl

use strict;
use warnings;

use feature 'switch';
use experimental 'switch'; # Supress warnings regarding when statements.

print "Enter a credit card type: ";
my $card = <STDIN>; # read the standard input and assign it to a variable
chomp $card;  # remove the newline character at the end of the string. The $/.
$card =~ s/^\s+|\s+$//g; # remove leading and trailing spaces
$card = lc $card; # convert to lowercase

given ($card) {
    when ('visa') {
        print "Visa card will be checked on the log files.\n";
    }
    when ('mastercard') {
        print "MasterCard card will be checked on the log files.\n";
    }
    when ('american express') {
        print "American Express card will be checked on the log files.\n";
    }
    when ('discover') {
        print "Discover card will be checked on the log files.\n";
    }
    default {
        print "Unrecognized card type!\n";
    }
    # Using a regular expression that matches the exact string with no additional characters before or after it ==> when (/^MasterCard$/)
}