package App::Provision::RepoUpdate;
use strict;
use warnings;
use parent qw( App::Provision );

sub condition
{
    my $self = shift;
    die "Program 'repoupdate' must include a --repo\n"
        if $self->{program} eq 'repoupdate' && !$self->{repo};
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
