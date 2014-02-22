package App::Provision::Git;
use strict;
use warnings;
use parent qw( App::Provision::Tiny );

sub git
{
    my $self = shift;
    $self->recipe(
      [qw( brew install git )],
    );
}

1;
