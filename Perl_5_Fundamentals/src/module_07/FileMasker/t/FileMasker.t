# Before 'make install' is performed this script should be runnable with
# 'make test'. After 'make install' it should work as 'perl FileMasker.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use strict;
use warnings;
use FileMasker;

use Test::More tests => 3;
#BEGIN { use_ok('FileMasker') };

my $mask_expected = 'CARD NUMBER: ************6828';
my $mask_result = FileMasker::mask_card_number('CARD NUMBER: 6011490036796828');
is($mask_result, $mask_expected, 'mask_card_number test with uppercase');

ok(FileMasker::sum(6,6) == 12, "sum test");

ok(FileMasker::mask_card_number('Card number: 6011490036796828') ne 'Card number: 6011490036796828', "mask_card_number test with lowercase");

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

