package App::Provision::SourceTree;
use strict;
use warnings;
use parent qw( App::Provision::Tiny );

sub deps
{
    return qw( wget );
}

sub condition
{
    my $self = shift;

    die "Program '$self->{program}' must include a --release\n"
        unless $self->{release};

    # The program name is a special case for OSX.apps.
    $self->{program} = '/Applications/SourceTree.app';

    my $condition = -d $self->{program};
    warn $self->{program}, ' is', ($condition ? '' : "n't"), " installed\n";

    return $condition ? 1 : 0;
}

sub meet
{
    my $self = shift;
    if ( $self->{system} eq 'osx' )
    {
        $self->recipe(
          [ 'wget', "http://downloads.atlassian.com/software/sourcetree/SourceTree_$self->{release}.dmg", '-P', "$ENV{HOME}/Downloads/" ],
          [ 'hdiutil', 'attach', "$ENV{HOME}/Downloads/SourceTree_$self->{release}.dmg", ],
          [ 'cp', '-r', '/Volumes/SourceTree/SourceTree.app', '/Applications/' ],
          [ 'hdiutil', 'detach', '/Volumes/SourceTree' ],
        );
    }
}

1;
