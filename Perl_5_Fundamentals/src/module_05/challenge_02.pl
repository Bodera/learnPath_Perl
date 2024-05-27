#!/usr/bin/perl

use strict;
use warnings;

print
  "Enter the credit card brands (visa, american express, maestro, all...): \n";
my $str_card_types = <STDIN>;

# the user can input the word all to indicate any credit card
# the user must provide the card brands separeted by comma and space
my @card_types = split /, /, $str_card_types;

# if you hardcoded the path, remember the need to add double backslashes at the end (\) because \ is a scape character
print "Enter log directory: \n";
my $log_directory = <STDIN>;
$log_directory =~ s/^\s+|\s+$//g;    # trim

my $directory_handle;
opendir( $directory_handle, $log_directory )
  or die "Could not open $log_directory: $!";

print "Start reading the log files...\n";

my $output_filename = $log_directory . 'output_2.txt';
open( my $output_file_handle, '>>', $output_filename );

while ( my $filename = readdir($directory_handle) ) {
    if ( $filename =~ /transaction.log$/ ) {
        print "Opening file: $filename\n";
        open( my $file_handle, '<', $log_directory . $filename ) or die $!;

        while (<$file_handle>) {
            for my $card (@card_types) {
                $card =~ s/[\r\n]+//g;     #fancy way to remove line breaks
                $card =~ s/^\s+|\s+$//g;   #fancy way to trim

                if ( lc($_) !~ lc($card) ) {
                    print "operation not detected. \n";
                    print $output_file_handle " Credit Card $card NOT Found in line $.\n";
                }
            }
        }

        print "Closing file: $filename\n";
        close $output_file_handle;
        close $file_handle;
    }
}
