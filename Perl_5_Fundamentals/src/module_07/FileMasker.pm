package FileMasker;

# takes a string as parameter, them print it to the console
sub log {
    print "^^^ $_[0] ^^^\n";
}

=begin pod
Title: open_file
Synopsis: This subroutine abstracts the file opening process. 
            It takes the file name to open based on given file mode, and return a file handle.
Usage: open_file($str, $file_mode)
Parameters:
    $str - the name of the file (full path).
    $file_mode - the mode in which the file will be opened.
Returns:
    A file handler to the opened file.
Example:
    my $file_handle = open_file($filename, '+<');
=cut pod
sub open_file {
    # we use shift to fetch the first parameter from the array of parameters
    my $input_file = shift;

    # tries to open the file in read and write mode, otherwise aborts printing the error message.
    # notice that after using `shift`, the array has one element less.
    open (my $file_handle, $_[0], $input_file) or die $!;
    return $file_handle;
}

=begin pod
Title: mask_card_number
Synopsis: This subroutine masks the credit card number in the file.
            The criteria looks for a piece of text 'NUMBER: ' followed by a sequence of numbers.
            Then replace the sequence of numbers with asterisks, except the last 4 digits.
Usage: mask_card_number($_) - where $_ is a line of the file.
Parameters:
    $line - The line to mask.
Returns:
    The masked line.
Example:
    my $masked_line = mask_card_number($_);
=cut pod
sub mask_card_number {
    my $line = shift;
    $line =~ s/(?<=NUMBER:\s)(\d+)(?=\d{4})/'*' x length($1)/e;
    return $line;
}

#return true.
1;