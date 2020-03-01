package App::Provision::Curl;
use strict;
use warnings;
use parent qw( App::Provision::Tiny );

=head1 FUNCTIONS

=head2 deps

=cut

sub deps
{
    return qw( homebrew );
}

=head2 meet

=cut

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
