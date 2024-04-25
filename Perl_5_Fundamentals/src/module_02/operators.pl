#!/usr/bin/perl

use strict;
use warnings;

print "We can print this" . " three times using one line of code!\n" x 3;

print '\n'; #prints the literal \n
print "\n"; #breaks the line

=begin
Perl's sprintf permits the following universally-known conversions:
Check more out at: https://perldoc.perl.org/functions/sprintf
=cut

print "10 in base 10 is " . sprintf("%d", 10) . "\n"; # 10
print "10 in base 2 is " . sprintf("%b", 10) . "\n"; # 1010
print "10 in base 16 is " . sprintf("%x", 10) . "\n"; # a
print "10 in base 8 is " . sprintf("%o", 10) . "\n"; # 12

print "--------------\n";

my $base_ten_number = 10;
my $binary_number = 0b1010;
my $hexadecimal_number = 0xA;
my $octal_number = 012;

print "Base ten number: $base_ten_number\n";
print "Binary number: $binary_number\n";
print "Hexadecimal number: $hexadecimal_number\n";
print "Octal number: $octal_number\n";

print "--------------\n";

print "5 + 5 equals to: ", 5 + 5, "\n";
print "5 - 5 equals to: ", 5 - 5, "\n";
print "5 * 5 equals to: ", 5 * 5, "\n";
print "5 / 5 equals to: ", 5 / 5, "\n";
print "5 % 5 equals to: ", 5 % 5, "\n";
print "5 ** 5 equals to: ", 5 ** 5, "\n";
print "5 <=> 5 equals to: ", 5 <=> 5, "\n";

print "--------------\n";

if (5 == 5 and 2 == 2) {
    print "AND\n";
}

if (3 == 4 or 2 == 2) {
    print "OR\n";
}

if (!(5 != 5)) {
    print "NOT\n";
}

print "--------------\n";

my $val_true = 1;
my $val_false = 0;

print "Logical AND: ", $val_true && $val_false, "\n";
print "Logical OR: ", $val_true || $val_false, "\n";
print "Logical NOT: ", !$val_true, "\n";

print "--------------\n";

my $user = q/sillymoose/;
my $difficult_string_interpolated = qq{Welcome $user.\nWhilst you are are here, you can "do as they do in Rome" and enjoy yourself};
print $difficult_string_interpolated, "\n";

print "--------------\n";

my $name = "Salamanca";
print length($name), "\n";
print lc($name), "\n";
print uc($name), "\n";
print ucfirst($name), "\n";
print lcfirst($name), "\n";

=begin
Some usage of reverse when not explicitly called in SCALAR context with strings
my $name_reversed = reverse $name;
print $name_reversed, "\n";
=cut
print scalar reverse $name;
print "\n";

print "--------------\n";

print substr($name, 0, 4), "\n";
print substr($name, -5), "\n";

print substr $name, 0, 4, "Mr. "; # prints Sala
print "\n";
print $name, "\n"; # prints Mr. manca

