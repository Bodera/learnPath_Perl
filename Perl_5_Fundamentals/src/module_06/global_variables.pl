#!usr/bin/perl
use strict;
use warnings;

my $company_name = "ScriptMakers Inc.";
my $company_address = "123 Main Street";

print "$company_name\n";
print "$company_address\n";

print "===================\n";

sub print_company_info {
    $company_address = "456 Boulevard Avenue";
    print "$company_name\n";
    print "$company_address\n";
}

&print_company_info;

print "===================\n";

print "$company_name\n";
print "$company_address\n";