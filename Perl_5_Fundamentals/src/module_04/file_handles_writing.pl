#!/usr/bin/perl

use strict;
use warnings;

my $log_directory = <STDIN>;

chomp $log_directory;
$log_directory =~ s/^\s+|\s+$//g;

# Please be gentle an provide the full path
print "Log directory is: $log_directory\n";

my $openSuccessful = opendir(my $directory_handle, $log_directory);
if ($openSuccessful) {
    print "Opened $log_directory successfully\n";
} else {
    print "Could not open $log_directory: $!\n";
}

print "Start reading the log files...\n";

my $output_filename = $log_directory.'output.txt';
open (my $output_file_handle, '>>', $output_filename);

while (my $filename = readdir($directory_handle)) {
    if ($filename =~ /\.log$/) {
        print "Opening file: $filename\n";

        open(my $file_handle, '<', $log_directory.$filename);
        while (<$file_handle>) {
            print "$_\n";

            if ($_ =~ /Store/) {
                print "Store transaction detected!\n";
                print $output_file_handle "Store transaction detected!\n";
            }
        }

        print "Closing file: $filename\n";
        close $output_file_handle;
        close $file_handle;
    }
}
