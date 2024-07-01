#!/usr/bin/perl

use warnings;

format CARD_DETAILS =
Card: @<<<<<<<<<<<<<<<< Ocurrence: @####
$name, $ocurrence
.

select(STDOUT);
$~ = CARD_DETAILS;

my @cards = ('Visa', 'MasterCard', 'American Express', 'Discover', 'Maestro');
my @card_ocurrences = (111, 77, 98, 53, 109);

$i = 0;
foreach(@cards) {
    $name = $cards[$i];
    $ocurrence = $card_ocurrences[$i];
    $i++;
    write;
}