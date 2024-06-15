#!usr/bin/perl
use strict;
use warnings;

sub print_timestamp {
    my $timestamp = localtime(); # get current timestamp based on location

    print "This script was run on: $timestamp\n";
}

&print_timestamp;

# another way to call a subroutine

print_timestamp();

# reference to a subroutine and dereferencing it

my $timestamp_ref = \&print_timestamp;

&$timestamp_ref;