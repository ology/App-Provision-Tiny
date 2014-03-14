package App::Provision::Cpanmupdate;
use strict;
use warnings;
use parent qw( App::Provision::Tiny );

sub condition
{
    my $self = shift;

    die "Program '$self->{program}' must include a --repo\n"
        unless $self->{repo};

    return 0; # Always update.
}

sub meet
{
    my $self = shift;
    $self->recipe(
      [
"find $self->{repo} -type d -name lib | xargs -n 1 dirname | sort | while read line; do echo \$line && cd \$line && cpanm .; done"
      ],
    );
}

1;
