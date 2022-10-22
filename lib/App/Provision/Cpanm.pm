package App::Provision::Perlbrew;
use strict;
use warnings;
use parent qw( App::Provision::Tiny );

=head1 FUNCTIONS

=head2 deps

=cut

sub deps
{
    return qw( curl );
}

=head2 meet

=cut

sub meet
{
    my $self = shift;
    $self->recipe(
      [ 'curl -L http://cpanmin.us | perl - App::cpanminus' ],
    );
}

1;
