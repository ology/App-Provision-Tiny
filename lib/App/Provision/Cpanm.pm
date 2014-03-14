package App::Provision::Perlbrew;
use strict;
use warnings;
use parent qw( App::Provision::Tiny );

sub deps
{
    return qw( curl );
}

sub meet
{
    my $self = shift;
    $self->recipe(
      [ 'curl -L http://cpanmin.us | perl - App::cpanminus' ],
    );
}

1;
