package Card;

sub new {
    my ($class, $args) = @_;
    my $self = bless {
        card_name => $args->{card_name},
        card_num => $args->{card_num},
        card_sec_code => $args->{card_sec_code}
    }, $class;
}

=begin
Be aware of the use of the `bless` function.

sub new {
    my $class = shift;
    my $self = { card_name => shift, card_num => shift, card_sec_code => shift };
    bless $self, $class;
    return $self;
}
my $card = Card->new({'John Doe', '1234567890123456', 123});


sub new {
    my ($class, $args) = @_;
    my $self = bless {
        card_name => $args->{card_name},
        card_num => $args->{card_num},
        card_sec_code => $args->{card_sec_code}
    }, $class;
}
my $card = Card->new({card_name => 'John Doe', card_num => '1234567890123456', card_sec_code => 123});

=cut

sub to_string {
    my $self = shift;
    return "Card name: $self->{card_name}\nCard number: $self->{card_num}\nCard security code: $self->{card_sec_code}\n";
}

1;