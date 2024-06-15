#!usr/bin/perl
use strict;
use warnings;

my $card = 'Visa'; # $card is a scalar variable
my $card_ref = \$card; # $card_ref is a reference to $card

print "card: $card\n";
print "card_ref: $card_ref\n";
print "card_ref value: $$card_ref\n";

print "===================\n";

my @cards = ('MasterCard', 'Discover', 'Maestro');
my $cards_ref = \@cards;

print "cards_ref: $cards_ref\n";
print "cards_ref value: @$cards_ref\n";

print "===================\n";

my %cards_catalogue = (Visa => 0, MasterCard => 1, Discover => 2, Maestro => 3);
my $cards_catalogue_ref = \%cards_catalogue;

print "cards_catalogue_ref: $cards_catalogue_ref\n";

foreach my $k (keys %$cards_catalogue_ref) {
    print "$k: $cards_catalogue_ref->{$k}\n";
    print "$k: " . %cards_catalogue{$k} . "\n";
}

print "===================\n";

my @primary_card_brands = ('Visa', 'MasterCard', 'Discover', 'Maestro');
my @secondary_card_brands = ('Elo', 'Paypal', 'Skrill', 'Apple Pay');

my @two_dimensional_array = (
    @primary_card_brands,
    @secondary_card_brands
);

print "Element on second row and second column accessing flattened array: $two_dimensional_array[5]\n";

print "===================\n";

my $primary_card_brands_ref = \@primary_card_brands;
my $secondary_card_brands_ref = \@secondary_card_brands;

my @real_two_dimensional_array = (
    $primary_card_brands_ref,
    $secondary_card_brands_ref
);

print "Element on second row and second column accessing array of references: $real_two_dimensional_array[1][1]\n";