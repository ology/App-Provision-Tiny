package App::Provision::Mysql;
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
    if ( $self->{system} eq 'osx' )
    {
        $self->recipe(
          [qw( brew install mysql )],
          [ 'unset TMPDIR && mysql_install_db --verbose --user=`whoami` --basedir="$(brew --prefix mysql)" --datadir=/usr/local/var/mysql --tmpdir=/tmp' ],
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
