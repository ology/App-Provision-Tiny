package App::Provisioner::Perlbrew;
use strict;
use warnings;
use parent qw( App::Provisioner );

sub perlbrew {
    my $self = shift;
    $self->recipe(
      [ 'curl -L http://install.perlbrew.pl | bash' ],
      [ "echo 'source ~/perl5/perlbrew/etc/bashrc >> $ENV{HOME}/.bash_profile" ],
      [qw( perlbrew install perl-5.18.2 )],
      [qw( perlbrew switch perl-5.18.2 )],
    );
}

1;
