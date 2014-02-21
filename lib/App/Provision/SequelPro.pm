package App::Provision::SequelPro;
use strict;
use warnings;
use parent qw( App::Provision );

sub condition
{
    my $self = shift;
    $self->{program} = '/Applications/Sequel Pro.app';
    my $condition = -d $self->{program};
    warn $self->{program}, ($condition ? 'is' : "isn't"), " installed\n";
    return $condition ? 1 : 0;
}

sub sequelpro
{
    my $self = shift;
    if ( $self->{system} eq 'osx' )
    {
        $self->recipe(
          [ 'wget', 'https://sequel-pro.googlecode.com/files/sequel-pro-1.0.2.dmg', '-P', "$ENV{HOME}/Downloads/" ],
          [ 'hdiutil', 'attach', "$ENV{HOME}/Downloads/sequel-pro-1.0.2.dmg", ],
          [ 'cp', '-r', '/Volumes/Sequel Pro 1.0.2/Sequel Pro.app', '/Applications/' ],
          [ 'hdiutil', 'detach', '/Volumes/Sequel Pro 1.0.2' ],
        );
    }
}

1;
