#!/usr/bin/perl

use warnings;

# assigns a value of $ARGV[0] to a scalar variable $dirname
# similarly how argv is used in C
$dirname = $ARGV[0]; # get the directory name

print "We will scan for unmasked credit card numbers in the directory: $dirname\n"; # using variable interpolation

$dirname = <STDIN>; # read the standard input. also diamond operator can be omitted.

print "Now we will scan for unmasked credit card numbers in the directory: $dirname\n"; # using variable interpolation