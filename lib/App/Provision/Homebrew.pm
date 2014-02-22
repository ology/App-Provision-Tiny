package App::Provision::Homebrew;
use strict;
use warnings;
use parent qw( App::Provision::Tiny );

sub condition
{
    my $self = shift;

    # Reset the program name.
    $self->{program} = 'brew';

    my $condition = -e $self->{program};
    warn $self->{program}, ' is', ($condition ? '' : "n't"), " installed\n";

    return $condition ? 1 : 0;
}

sub homebrew
{
    my $self = shift;
    $self->recipe(
      [ 'ruby', '-e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"' ],
      [ 'brew', 'doctor' ],
    );
}

1;
