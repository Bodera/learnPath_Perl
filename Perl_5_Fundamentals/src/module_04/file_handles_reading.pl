#!/usr/bin/perl

use strict;
use warnings;

my $log_directory = <STDIN>;

=begin
Chomp: The chomp() function will remove (usually) any newline character from the end of a string. 
The reason we say usually is that it actually removes any character that matches the current value 
of $/ (the input record separator), and $/ defaults to a newline.

There is no trim function in Perl, so either use a third-party library or use a regular expression.
=cut

chomp $log_directory;
$log_directory =~ s/^\s+|\s+$//g;

# Please be gentle an provide the full path
print "Log directory is: $log_directory\n";

# The opendir function returns a boolean value (0 or 1) indicating whether or not the directory was opened successfully.
=begin
too early for you using this code, let's write the ugly way first.
opendir(my $directory_handle, $log_directory) or die "Could not open $log_directory: $!";
=cut

# "$!" is perl special variable
# Same as $OS_ERROR and $ERRNO
# https://perldoc.perl.org/perlvar#SPECIAL-VARIABLES
my $openSuccessful = opendir(my $directory_handle, $log_directory);
if ($openSuccessful) {
    print "Opened $log_directory successfully\n";
} else {
    print "Could not open $log_directory: $!\n";
}

print "Start reading the log files...\n";

# The readdir function returns the next filename in the directory.
# So we are looping through all the files in the directory
while (my $filename = readdir($directory_handle)) {
    # Skip files that do not end with .log
    # Same logic as: if (substr($filename, -4) eq '.log')
    if ($filename =~ /\.log$/) {
        print "Opening file: $filename\n";
        
        # The second parameter of the open function indicates the mode in which the file will be opened.
        # https://perldoc.perl.org/functions/open#About-modes
        # < means read only
        # notice that the filename must correspond to the full path of the file
        open(my $file_handle, '<', $log_directory.$filename);

        #seek($file_handle, 1818, 0);
        #while (<$file_handle>) {
        #    print tell($file_handle), "  $_\n";
        #}

        while (<$file_handle>) {
            print "$_\n";
        }

        print "Closing file: $filename\n";
        close $file_handle;
    }
}
