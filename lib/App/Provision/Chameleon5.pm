package App::Provision::Chameleon5;
use strict;
use warnings;
use parent qw( App::Provision::Tiny );

sub condition
{
    my $self = shift;

    die "Program '$self->{program}' must include a --repo ~/repos\n"
        unless $self->{repo};

    my $condition = -d "$self->{repo}/chameleon5";
    warn $self->{program}, ' is', ($condition ? '' : "n't"), " installed\n";

    return $condition ? 1 : 0;
}

sub meet
{
    my $self = shift;
    $self->recipe(
      [ qw( git clone git@github.com:Whapps/chameleon5.git ), "$self->{repo}/chameleon5" ],
      [ 'cp', "$self->{repo}/chameleon5/bin/sample_dev_c5.pl", "$self->{repo}/chameleon5/bin/c5.pl" ],
      [ 'cpanm', "$self->{repo}/chameleon5/modules/Chameleon5" ],
      [ 'cpanm', "$self->{repo}/chameleon5/modules/Chameleon5-Contrib" ],
    );
}

1;
