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

    $self->{release} ||= '5.18.2';

    $self->recipe(
      [ 'curl -L http://install.perlbrew.pl | bash' ],
      [ 'touch', "$ENV{HOME}/.bash_profile" ],
      [ "echo 'source ~/perl5/perlbrew/etc/bashrc' >> $ENV{HOME}/.bash_profile" ],
      [ "`source', $ENV{HOME}/.bash_profile`" ],
      [qw( perlbrew install ), "perl-$self->{release}" ],
      [qw( perlbrew switch ), "perl-$self->{release}" ],
    );
}

1;
