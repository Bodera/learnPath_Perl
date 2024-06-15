#!/usr/bin/perl

use strict;
use warnings;

print "Enter log directory: \n";
my $log_directory = <STDIN>;
$log_directory =~ s/^\s+|\s+$//g;    # trim

my $directory_handle;
opendir( $directory_handle, $log_directory ) or die "Could not open $log_directory: $!";

print "Start reading the final challenge log files...\n";

while ( my $filename = readdir($directory_handle) ) {
    if ( $filename =~ /final_challenge.log/ ) {
        print "Opening file: $filename\n";
        open( my $file_handle, '+<', $log_directory . $filename ) or die $!; # open file in read and write mode

        my $read_pos = tell($file_handle);    #holds current position of the reading pointer
        while (<$file_handle>) {
            $_ =~ tr/[a-z]/[A-Z]/;            # converts all lowercase to uppercase
            if ( $_ =~ s/(?<=NUMBER:\s)(\d+)(?=\d{4})/'*' x length($1)/e ) { 

                # after detecting the line with credit card details prepares to rewrite.
                # 0 - reads from the beginning
                # 1 - reads from the current position
                # 2 - reads from the end
                # since we're gonna replace entire line, zero works just fine.
                seek( $file_handle, $read_pos, 0 );
                print $file_handle $_;
            }

            $read_pos = tell($file_handle);
        }

        print "Closing file: $filename\n";
        close $file_handle;
    }
}
