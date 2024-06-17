#!/usr/bin/perl
use strict;
use warnings;

require FileMasker;

=begin pod
Title: to_upper_case
Synopsis: This subroutine converts a string to uppercase.
Usage: to_upper_case($str)
Parameters:
    $str - The string to convert to uppercase.
Returns:
    The converted string.
Example:
    my $string = "hello world";
    to_upper_case($string);
    print $string; # prints "HELLO WORLD"
=cut pod
sub to_upper_case {
    my $str = $_[0];
    $str =~ tr/[a-z]/[A-Z]/;
    return $str;
}

=begin pod
Title: mask_card_number
Synopsis: This subroutine masks the credit card number in the file.
Usage: mask_card_number($file_handle)
Parameters:
    $file_handle - The file handle to read from.
Returns:
    None.
Example:
    open(my $file_handle, '+<', $filename) or die $!;
    mask_card_number($file_handle);
    close $file_handle;
=cut pod
sub mask_card_number {
    my $file_handle = $_[0];
    my $read_pos = tell($file_handle);
    while (<$file_handle>) {
        $_ = to_upper_case($_);
        if ( $_ = FileMasker::mask_card_number($_) ) {
            seek( $file_handle, $read_pos, 0 );
            print $file_handle $_;
        }
        $read_pos = tell($file_handle);
    }
}

print "Enter log directory: \n";
my $log_directory = <STDIN>;
$log_directory =~ s/^\s+|\s+$//g;    # trim

my $directory_handle;
opendir( $directory_handle, $log_directory ) or die "Could not open $log_directory: $!";

FileMasker::log("Start reading the final challenge log files...");

while ( my $filename = readdir($directory_handle) ) {
    if ( $filename =~ /final_challenge.log/ ) {
        FileMasker::log("Opening file: $filename");
        my $file_handle = FileMasker::open_file( $log_directory . $filename, '+<' );
        mask_card_number($file_handle);
        FileMasker::log("Closing file: $filename");
        close $file_handle;
    }
}
