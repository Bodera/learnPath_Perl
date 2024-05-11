#!/usr/bin/perl

use strict;
use warnings;
use Carp;

sub where_am_i {
    warn "Function called from ", (caller)[1], " at ", (caller)[2], "\n";
}

sub where_am_i_carp {
    carp "Function called from ", (caller)[1], " at ", (caller)[2], "\n";
}

where_am_i();
where_am_i_carp();
