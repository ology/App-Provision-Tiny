package App::Provision::Wget;
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
          [qw( brew install wget )],
        );
    }
    elsif ($self->{system} eq 'apt' )
    {
        $self->recipe(
          [qw( sudo apt-get install wget )],
        );
    }
}

1;
