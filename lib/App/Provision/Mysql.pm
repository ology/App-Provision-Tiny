package App::Provision::Mysql;
use strict;
use warnings;
use parent qw( App::Provision::Tiny );

sub mysql
{
    my $self = shift;
    if ( $self->{system} eq 'osx' )
        $self->recipe(
          [qw( brew install mysql )],
        );
    }
    elsif ( $self->{system} eq 'apt' )
    {
        $self->recipe(
          [qw( sudo apt-get install mysql )],
        );
    }
}

1;
