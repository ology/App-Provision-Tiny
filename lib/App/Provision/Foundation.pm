package App::Provision::Foundation;
use strict;
use warnings;
use parent qw( App::Provision::Tiny );

=head1 FUNCTIONS

=head2 deps

=cut

sub deps
{
    my $self = shift;
    return qw( wget unzip );
}

=head2 condition

=cut

sub condition
{
    my $self = shift;

    die "Program '$self->{program}' must include a --site and --release\n"
        unless $self->{site} && $self->{release};

    my $condition = -e "$self->{site}/js/foundation.min.js";
    warn $self->{program}, ' is', ($condition ? '' : "n't"), " installed\n";

    return $condition ? 1 : 0;
}

=head2 meet

=cut

sub meet
{
    my $self = shift;
    $self->recipe(
      [ 'wget', "http://foundation.zurb.com/cdn/releases/foundation-$self->{release}.zip", '-P', "$ENV{HOME}/Downloads/" ],
      [ 'unzip', "$ENV{HOME}/Downloads/foundation-$self->{release}.zip", '-d', "$ENV{HOME}/Downloads/foundation/" ],
      # TODO Make these a single * glob:
      [ 'mv', "$ENV{HOME}/Downloads/foundation/index.html", $self->{site} ],
      [ 'mv', "$ENV{HOME}/Downloads/foundation/css", $self->{site} ],
      [ 'mv', "$ENV{HOME}/Downloads/foundation/img", $self->{site} ],
      [ 'mv', "$ENV{HOME}/Downloads/foundation/js", $self->{site} ],
    );
}

1;
