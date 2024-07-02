#!/usr/bin/perl

use strict;
use warnings;
require Card;
require Chipcard;

my $card = Card->new({card_name => 'John Doe', card_num => '1234567890123456', card_sec_code => 123});
my $chipcard = Chipcard->new({card_name => 'Mary Doe', card_num => '6543210987654321', card_sec_code => 321});

print $card->to_string;
print $chipcard->to_string;