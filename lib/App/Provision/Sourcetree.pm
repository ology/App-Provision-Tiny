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
          [ 'wget', 'http://downloads.atlassian.com/software/sourcetree/SourceTree_1.8.1.dmg', '-P', "$ENV{HOME}/Downloads/" ],
          [ 'hdiutil', 'attach', "$ENV{HOME}/Downloads/SourceTree_1.8.1.dmg", ],
          [ 'cp', '-r', '/Volumes/SourceTree/SourceTree.app', '/Applications/' ],
          [ 'hdiutil', 'detach', '/Volumes/SourceTree' ],
        );
    }
}

1;
