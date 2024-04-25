#!/usr/bin/perl

use strict; # pragma

use feature 'say'; # Perl 5.10+ automatically appends a newline at the end of the print statement.

use constant NUM_CARDS => 4;

say "Printing number of cards inside double quotes: ${ \ NUM_CARDS }";

say 'Printing number of cards inside single quotes: ', NUM_CARDS;

my $card1 = "1234-1234-1234-1234";

say "Card number: $card1";

my $card_num_length = 12; # 12 digits
my $sec_code_length = 3; # 3 digits
my $total_length = 51;
my $random_value = 123;

{
    my $total_length = $card_num_length + $sec_code_length;
    $random_value = 321;
    say "Total length: $total_length";
}

say "Total length now is: $total_length";

say "Random value: $random_value";