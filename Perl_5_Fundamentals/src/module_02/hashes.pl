#!/usr/bin/perl

use strict;
use warnings;

my %hash = ('a' => 1, 'b' => 2, 'c' => 3);
print $hash{'b'}, "\n";
print("Value of the first element is $hash{'a'}\n");

# my %hash = qw(a 1 b 2 c 3);

# If you the following two lines repeatedly, you'll notice the order of elements on hash changes.
# This is because the hash is a random collection of elements.
print("All keys on the hash: ", keys(%hash), "\n");
print("All values on the hash: ", values(%hash), "\n");

# To get the number of elements in the hash, use the scalar function
print("Size of the hash: ", scalar %hash, "\n");
my $hash_size = %hash;
print("Size of the hash: ", $hash_size, "\n");

# Adding and updating elements
$hash{d} = 4;
print("Value of the added element is $hash{'d'}\n");
$hash{d} = 5;
print("Value of the updated element is $hash{'d'}\n");


# Deleting elements
print("Size of the hash: ", scalar %hash, "\n");
delete $hash{d};
print("Size of the hash: ", scalar %hash, "\n");