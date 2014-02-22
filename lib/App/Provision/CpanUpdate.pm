package App::Provision::CpanUpdate;
use strict;
use warnings;
use parent qw( App::Provision::Tiny );

sub condition
{
    my $self = shift;

    $self->{program} = 'cpanupdate';

    die "Program '$self->{program}' must include a --repo\n"
        unless $self->{repo};

    my $condition = 0;
    warn "Always update!\n";

    return $condition;
}

sub cpanupdate
{
    my $self = shift;
    $self->recipe(
      [
"find $self->{repo} -type d -name lib | xargs -n 1 dirname | sort | while read line; do echo \$line && cd \$line && cpanm .; done"
      ],
    );
}

1;
