package App::Provision::Homebrew;
use strict;
use warnings;
use parent qw( App::Provision::Tiny );
use File::Which;

sub deps
{
    return qw( ruby curl homebrew );
}

sub condition
{
    my $self = shift;

    # Reset the program name.
    $self->{program} = 'brew';

    my $callback  = shift || sub { which($self->{program}) };
    my $condition = $callback->();

    warn $self->{program}, ' is', ($condition ? '' : "n't"), " installed\n";

    return $condition ? 1 : 0;
}

sub meet
{
    my $self = shift;
    $self->recipe(
      [ 'ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"' ],
      [ 'brew', 'doctor' ],
    );
}

1;
