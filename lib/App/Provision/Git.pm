package App::Provision::Git;
use strict;
use warnings;
use parent qw( App::Provision );

sub git
{
    my $self = shift;
    $self->recipe(
      [qw( brew install git )],
    );
}

1;
