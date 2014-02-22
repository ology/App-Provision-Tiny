package App::Provision::RepoUpdate;
use strict;
use warnings;
use parent qw( App::Provision::Tiny );

sub condition
{
    my $self = shift;

    $self->{program} = 'repoupdate';

    die "Program '$self->{program}' must include a --repo\n"
        unless $self->{repo};

    my $condition = 0;
    warn "Always update!\n";

    return $condition;
}

sub repoupdate
{
    my $self = shift;
    $self->recipe(
      [
"find $repo -type d -name .git | xargs -n 1 dirname | sort | while read line; do echo \$line && cd \$line && git pull; done"
      ],
    );
}

1;
