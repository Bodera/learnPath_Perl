#!/usr/bin/perl

use strict;
use warnings;

# if you hardcoded the path, remember the need to add double backslashes at the end (\) because \ is a scape character
print "Enter log directory: \n";
my $log_directory = <STDIN>;
$log_directory =~ s/^\s+|\s+$//g;    # trim

my $directory_handle;
opendir( $directory_handle, $log_directory )or die "Could not open $log_directory: $!";

print "Start reading the log files...\n";

my $output_filename = $log_directory . 'output_4.txt';
open( my $output_file_handle, '>>', $output_filename );

while ( my $filename = readdir($directory_handle) ) {
    if ( $filename =~ /transaction.log/ ) {
        print "Opening file: $filename\n";
        open( my $file_handle, '<', $log_directory . $filename ) or die $!;

        while (<$file_handle>) {
            my @matches = ($_ =~ /((?<= brand:)\s+\b(\w+)\b|\d{15,})/gmi);
            my $card_brand = $matches[1];
            my $card_number = $matches[2];

            if ($card_brand ne "" && $card_number ne "") {
                print ("Credit Card Brand: $card_brand, with Number: $card_number, found at line $.\n");
                print $output_file_handle "Credit Card Brand: $card_brand, with Number: $card_number, found at line $.\n";
            }
        }

        print "Closing file: $filename\n";
        close $output_file_handle;
        close $file_handle;
    }
}
