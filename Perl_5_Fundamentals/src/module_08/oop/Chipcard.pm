package Chipcard;
require Card;

our @ISA = qw(Card);

sub to_string {
    my $self = shift;
    return "Chip Card name: $self->{card_name}\nChip Card number: $self->{card_num}\nChip Card security code: $self->{card_sec_code}\n";
}

1;