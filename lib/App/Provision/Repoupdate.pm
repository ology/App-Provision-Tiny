package App::Provision::Repoupdate;
use strict;
use warnings;
use parent qw( App::Provision::Tiny );

=head1 FUNCTIONS

=head2 condition

=cut

sub condition
{
    my $self = shift;

    die "Program '$self->{program}' must include a --repo\n"
        unless $self->{repo};

    return 0; # Always update
}

=head2 meet

=cut

sub meet
{
    my $self = shift;
    $self->recipe(
      [
"find $self->{repo} -type d -name .git | xargs -n 1 dirname | sort | while read line; do echo \$line && cd \$line && git pull; done"
      ],
    );
}

1;
