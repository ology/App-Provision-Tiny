package App::Provision::Ssh;
use strict;
use warnings;
use parent qw( App::Provision::Tiny );

sub condition
{
    my $self = shift;

    die "Program '$self->{program}' must include --keytype and --keyname\n"
        unless $self->{keytype} && $self->{keyname};

    # Set the keyfile attribute.
    $self->{keyfile} = sprintf '%s/.ssh/id_%s-%s', $ENV{HOME},
        $self->{keytype}, $self->{keyname};

    my $condition = -e $self->{keyfile};
    warn $self->{program}, ' is', ($condition ? '' : "n't"), " installed\n";

    return $condition ? 1 : 0;
}

sub meet
{
    my $self = shift;
    $self->recipe(
      [ 'ssh-keygen', '-t', $self->{keytype}, '-f', $self->{keyfile} ],
      [ "cat $self->{keyfile}.pub | tr -d '\n' | pbcopy" ],
      [ 'echo', '* Now paste your public key into https://github.com/settings/ssh *' ],
    );
}

1;
