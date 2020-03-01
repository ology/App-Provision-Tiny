package App::Provision::Homebrew;
use strict;
use warnings;
use parent qw( App::Provision::Tiny );
use File::Which;

sub deps
{
    return qw( ruby curl );
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
    if ($self->{system} eq 'osx' )
    {
        $self->recipe(
            [ 'ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"' ],
            [ 'brew', 'doctor' ],
        );
    }
    elsif ($self->{system} eq 'apt' )
    {
        $self->recipe(
            [ 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"' ],
            [ 'test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)' ],
            [ 'test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' ],
            [ 'test -r ~/.profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile' ],
            [ 'echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile' ],
        );
    }
}

1;
