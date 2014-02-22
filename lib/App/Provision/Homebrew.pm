package App::Provision::Homebrew;
use strict;
use warnings;
use parent qw( App::Provision );

sub condition
{
    my $self = shift;
    $self->{program} = 'brew';
    my $condition = -e $self->{program};
    warn $self->{program}, ($condition ? 'is' : "isn't"), " installed\n";
    return $condition ? 1 : 0;
}

sub homebrew {
    my $self = shift;
    $self->recipe(
      [ 'ruby', '-e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"' ],
      [ 'brew', 'doctor' ],
    );
}

1;
