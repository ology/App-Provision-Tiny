package App::Provision::CpanUpdate;
use strict;
use warnings;
use parent qw( App::Provision::Tiny );

sub condition
{
    my $self = shift;

    die "Program 'cpanupdate' must include a --repo\n"
        if $self->{program} eq 'cpanupdate' && !$self->{repo};

    my $condition = 0;
    warn "Always update!\n";

    return $condition;
}

sub cpanupdate
{
    my $self = shift;
    $self->recipe(
      [
      ],
"find $repo -type d -name lib | xargs -n 1 dirname | sort | while read line; do echo \$line && cd \$line && cpanm .; done"
    );
}

1;
