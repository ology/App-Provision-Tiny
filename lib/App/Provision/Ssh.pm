package App::Provision::Ssh;
use strict;
use warnings;
use parent qw( App::Provision );

sub condition
{
    my $self = shift;

    die "Program 'ssh' must include --keytype and --keyname\n"
        if $self->{program} eq 'ssh'
            && !($self->{keytype} && $self->{keyname});

    # Set the keyfile attribute.
    $self->{keyfile} = sprintf '%s/.ssh/id_%s-%s', $ENV{HOME},
        $self->{keytype}, $self->{keyname};

    my $condition = -e $self->{keyfile};
    warn $self->{program}, ($condition ? 'is' : "isn't"), " installed\n";

    return $condition ? 1 : 0;
}

sub ssh {
    my $self = shift;
    $self->recipe(
      [ 'ssh-keygen', '-t', $self->{keytype}, '-f', $self->{keyfile} ],
      [ "cat $self->{keyfile}.pub | tr -d '\n' | pbcopy" ],
      [ 'echo', '* Now paste your public key into https://github.com/settings/ssh *' ],
    );
}

1;
