package App::Provision::Mysql;
use strict;
use warnings;
use parent qw( App::Provision );

sub mysql
{
    my $self = shift;
    $self->recipe(
      [qw( brew install mysql )],
    );
}

1;
