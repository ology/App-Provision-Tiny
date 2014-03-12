package App::Provision::Foundation;
use strict;
use warnings;
use parent qw( App::Provision::Tiny );

sub condition
{
    my $self = shift;

    die "Program '$self->{program}' must include a --repo and --site\n"
        unless $self->{repo} && $self->{site};

    my $condition = -e "$self->{site}/js/foundation.min.js";
    warn $self->{program}, ' is', ($condition ? '' : "n't"), " installed\n";

    return $condition ? 1 : 0;
}

sub meet
{
    my $self = shift;
    $self->recipe(
      [ 'wget', 'http://foundation.zurb.com/cdn/releases/foundation-5.1.1.zip', '-P', "$ENV{HOME}/Downloads/" ],
      [ 'unzip', "$ENV{HOME}/Downloads/foundation-5.1.1.zip", '-d', "$ENV{HOME}/Downloads/foundation/" ],
      # TODO Make these a single * glob:
      [ 'mv', "$ENV{HOME}/Downloads/foundation/index.html", "$self->{repo}/chameleon5/domains/$self->{site}/site_root/" ],
      [ 'mv', "$ENV{HOME}/Downloads/foundation/css", "$self->{repo}/chameleon5/domains/$self->{site}/site_root/" ],
      [ 'mv', "$ENV{HOME}/Downloads/foundation/img", "$self->{repo}/chameleon5/domains/$self->{site}/site_root/" ],
      [ 'mv', "$ENV{HOME}/Downloads/foundation/js", "$self->{repo}/chameleon5/domains/$self->{site}/site_root/" ],
    );
}

1;
