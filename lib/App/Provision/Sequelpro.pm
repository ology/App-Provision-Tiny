package App::Provision::Sequelpro;
use strict;
use warnings;
use parent qw( App::Provision::Tiny );

=head1 FUNCTIONS

=head2 deps

=cut

sub deps
{
    return qw( wget );
}

=head2 condition

=cut

sub condition
{
    my $self = shift;

    die "Program '$self->{program}' must include a --release\n"
        unless $self->{release};

    # The program name is a special case for OSX.apps.
    $self->{program} = '/Applications/Sequel Pro.app';

    my $condition = -d $self->{program};
    warn $self->{program}, ' is', ($condition ? '' : "n't"), " installed\n";

    return $condition ? 1 : 0;
}

=head2 meet

=cut

sub meet
{
    my $self = shift;
    if ( $self->{system} eq 'osx' )
    {
        $self->recipe(
          [ 'wget', "https://sequel-pro.googlecode.com/files/sequel-pro-$self->{release}.dmg", '-P', "$ENV{HOME}/Downloads/" ],
          [ 'hdiutil', 'attach', "$ENV{HOME}/Downloads/sequel-pro-$self->{release}.dmg", ],
          [ 'cp', '-r', "/Volumes/Sequel Pro $self->{release}/Sequel Pro.app", '/Applications/' ],
          [ 'hdiutil', 'detach', "/Volumes/Sequel Pro $self->{release}" ],
        );
    }
}

1;
