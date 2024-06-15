#!usr/bin/perl
use strict;
use warnings;

# Perl lets you create an array reference dynamically 
# when you enclose the elements within square brackets instead of parentheses.

my @arr_ref = ([10, 20, 30],
                [40, 50, 60]);

print "Element on second row and second column is: $arr_ref[1][1]\n";

print "===================\n";

# Perl lets you create a hash reference dynamically
# when you enclose the elements within curly braces instead of parentheses.

my $hash_ref = {
    'peter' => 'monkey',
    'psyche' => 'cat',
    'sarah' => 'dog'
};

print "Psyche's pet is: $hash_ref->{'sarah'}\n";
# also works
=begin
my $hash_ref = {
    "peter" => "monkey",
    "psyche" => "cat",
    "sarah" => "dog"
};
print "Psyche's pet is: $hash_ref->{sarah}\n";
=cut


