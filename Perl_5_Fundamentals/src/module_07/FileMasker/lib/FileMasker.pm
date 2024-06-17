package FileMasker;

use 5.032001;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use FileMasker ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	
);

our $VERSION = '0.01';


# Preloaded methods go here.

sub log {
    print "^^^ $_[0] ^^^\n";
}

sub open_file {
    # we use shift to fetch the first parameter from the array of parameters
    my $input_file = shift;

    # tries to open the file in read and write mode, otherwise aborts printing the error message.
    # notice that after using `shift`, the array has one element less.
    open (my $file_handle, $_[0], $input_file) or die $!;
    return $file_handle;
}

sub mask_card_number {
    my $line = shift;
    $line =~ s/(?<=NUMBER:\s)(\d+)(?=\d{4})/'*' x length($1)/e;
    return $line;
}

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

FileMasker - Perl extension for blah blah blah

=head1 SYNOPSIS

  use FileMasker;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for FileMasker, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.



=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

A. U. Thor, E<lt>a.u.thor@a.galaxy.far.far.awayE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2024 by A. U. Thor

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.32.1 or,
at your option, any later version of Perl 5 you may have available.


=cut
