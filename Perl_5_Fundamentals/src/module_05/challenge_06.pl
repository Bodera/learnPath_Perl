#!/usr/bin/perl

use strict;
use warnings;

# if you hardcoded the path, remember the need to add double backslashes at the end (\) because \ is a scape character
print "Enter log directory: \n";
my $log_directory = <STDIN>;
$log_directory =~ s/^\s+|\s+$//g;    # trim

my $directory_handle;
opendir( $directory_handle, $log_directory ) or die "Could not open $log_directory: $!";

print "Start reading the log files...\n";

my $output_filename = $log_directory . 'output_6.txt';
open( my $output_file_handle, '>>', $output_filename ) or die $!;

while ( my $filename = readdir($directory_handle) ) {
    if ( $filename =~ /transaction.log/ ) {
        print "Opening file: $filename\n";
        open( my $file_handle, '<', $log_directory . $filename ) or die $!;

        while (<$file_handle>) {
            $_ =~ tr/[a-z]/[A-Z]/;
            if ($_ =~ s/(?<=NUMBER:\s)(\d+)(?=\d{4})/'*' x length($1)/e) {
                print "Detected card number to be replaced at line $..\n";
                print $output_file_handle "$_";
            }
        }

        print "Closing file: $filename\n";
        close $output_file_handle;
        close $file_handle;
    }
}
