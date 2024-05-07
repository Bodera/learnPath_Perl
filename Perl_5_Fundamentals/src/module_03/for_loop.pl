#!/usr/bin/perl

use strict;
use warnings;

my @numbers = (2, 4, 6, 8, 10);

# Using the perl special variable $_ (because it's an array of scalars)
for (@numbers) {
    print "$_ * 2 = " . $_ * 2 . "\n";
}

print "============Without special variable==============\n";
for (@numbers) {
    print;
    print "\n";
}

# Using an iterator whose lyfetime ends at the end of the loop
print "============Using an iterator==============\n";
for my $number (@numbers) {
    print "$number * 2 = " . $number * 2;
    print "\n";
}

# it's the same as for, a synonym. There is no difference between them.
print "============Using foreach==============\n";
my @numbers = (2, 4, 6, 8, 10);
foreach (@numbers) {
    print "$_ * 2 = " . $_ * 2 . "\n";
}

# it's the same as for, a synonym. There is no difference between them.
print "============Using foreach==============\n";
for (my $number = 0; $number < 3; $number++) {
    print "@numbers[$number] * 2 = " . @numbers[$number] * 2 . "\n";
}