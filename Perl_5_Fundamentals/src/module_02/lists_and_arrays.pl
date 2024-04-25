#!usr/bin/perl

use strict;
use warnings;

# To convert lists to an array just use the @ operator

#Printing a list
print ((1, 2, 3, 4, 5), "\n");

#Flattening lists
print ((('a', 'b', 'c'), (4, 5, 6)), "\n");

#Finding the length of a list
print scalar (1, 2, 3, 4, 5, 6, 7, 8, 9, 10), "\n";

#Finding the last element of an array
my @list5 = (1, 2, 3, 4, 5);
print $list5[-1], "\n";

#Finding the fifth last element of an array
my @list5 = (1, 2, 3, 4, 5);
print $list5[-5], "\n";

#Use of uninitialized value in print
#my @list5 = (1, 2, 3, 4, 5);
#print $list5[-6], "\n";
#print $list5[6], "\n";

#Finding the third element of an array
my @list6 = (1, 2, 3, 4, 5);
print $list6[2], "\n";

print " Using the join function", "\n";
my @list7 = (1, 2, 3, 4, 5);
print join(',', @list7), "\n";

#Using the reverse function
my @list8 = (1, 2, 3, 4, 5);
print reverse(@list8), "\n";

#Using the sort function (ascending order)
my @list9 = (5, 4, 3, 2, 1);
print sort(@list9), "\n";

print "--------------\n"; 
print " Using the split function", "\n";
my @list10 = (1, 2, 3, 4, 5);
print split(',', join(',', @list10)), "\n";

#Using the grep function
#Using the qw function
my @list11 = qw(b 2 c);
print @list11, "\n";


my @list12 = (1, 2, 3, 4, 5);
my $var = @list12;
print ("Total of $var elements, and the highest index is $#list12. \n");

# Changing, adding, and deleting elements of an array
$list12[0] = 10;
$list12[1] = 20;
delete $list12[4];
print @list12, "\n";