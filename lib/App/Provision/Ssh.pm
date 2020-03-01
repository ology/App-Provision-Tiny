package App::Provision::Ssh;
use strict;
use warnings;
use parent qw( App::Provision::Tiny );

=head1 FUNCTIONS

=head2 condition

=cut

sub condition
{
    my $self = shift;

    die "Program '$self->{program}' must include --keytype and --keyname\n"
        unless $self->{keytype} && $self->{keyname};

    my $file = $self->_keyfile();
    my $condition = -e $file;
    warn $self->{program}, ' is', ($condition ? '' : "n't"), " installed\n";

    return $condition ? 1 : 0;
}

=head2 meet

=cut

sub meet
{
    my $self = shift;

    my $file = $self->_keyfile();

    $self->recipe(
      [ 'mkdir', '.ssh' ],
      [ 'chmod', '700', '.ssh' ],
      [ 'ssh-keygen', '-t', $self->{keytype}, '-f', $file ],
      [ "cat $ENV{HOME}/.ssh/$file.pub | tr -d '\n' | pbcopy" ],
      [ 'echo', '* Now paste your public key into https://github.com/settings/ssh *' ],
    );
}

sub _keyfile
{
    # Set the keyfile attribute.
    my $self = shift;
    return sprintf '%s/.ssh/id_%s-%s', $ENV{HOME},
        $self->{keytype}, $self->{keyname};
}

1;
