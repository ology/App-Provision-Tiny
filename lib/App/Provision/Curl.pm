package App::Provision::Curl;
use strict;
use warnings;
use parent qw( App::Provision::Tiny );

sub depends {
    return qw( homebrew );
}

sub meet
{
    my $self = shift;
    if ($self->{system} eq 'osx' )
    {
        $self->recipe(
          [qw( brew install curl )],
        );
    }
    elsif ($self->{system} eq 'apt' )
    {
        $self->recipe(
          [qw( sudo apt-get install curl )],
        );
    }
}

1;
