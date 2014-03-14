package App::Provision::Git;
use strict;
use warnings;
use parent qw( App::Provision::Tiny );

sub deps
{
    return qw( homebrew );
}

sub meet
{
    my $self = shift;
    if ($self->{system} eq 'osx' )
    {
        $self->recipe(
          [qw( brew install git )],
        );
    }
    elsif ($self->{system} eq 'apt' )
    {
        $self->recipe(
          [qw( sudo apt-get install git )],
        );
    }
}

1;
