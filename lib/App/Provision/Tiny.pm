package App::Provision::Tiny;

# ABSTRACT: Provision computers

use strict;
use warnings;

use File::Which;

our $VERSION = '0.02';

=head1 NAME

App::Provision::Tiny - Provision computers

=head1 SYNOPSIS

  # With the module:
  use App::Provision::Foo;
  $app = App::Provision::Foo->new;
  $app->meet;

  # On the command line:
  > provis homebrew
  > provis cpanmupgrade --repo ~/sandbox

=head1 DESCRIPTION

An C<App::Provision::Tiny> together with a sub-classed recipe module (like
C<Foo>), contain the methods to provision a workstation or server.

* Currently, the included recipes are for OS X machines.

=cut

=head1 METHODS

=head2 new()

  $app = App::Provision::Tiny->new(%arguments);

Create a new C<App::Provision::Tiny> object.

Argument: default

 program: undef
 system:  osx

=cut

sub new
{
    my $class = shift;
    my %args = @_;
    my $self = {};
    bless $self, $class;
    $self->_init(%args, class => $class);
    return $self;
}

sub _init
{
    my $self = shift;
    my %args = @_;

    # Turn arguments into object attributes.
    $self->{$_} = $args{$_} || undef for keys %args;

    # Set the system to provision.
    $self->{system} ||= 'osx';

    # Set the program to provision on the system.
    unless ($self->{program})
    {
        $self->{class} =~ s/App::Provision::(\w+)$/$1/;
        $self->{program} = lc $self->{class};
    }
}

=head2 condition()

This is the condition to check for the presence of a program, and is to
redefined in your subclass, if anything beyond effectively C<`which program`>
is needed.

=cut

sub condition
{
    my $self = shift;
    my $callback = shift || sub { which($self->{program}) };
    my $condition = $callback->();
    warn "$self->{program} ", ($condition ? 'is' : "isn't"), " installed\n";
    return $condition ? 1 : 0;
}

=head2 recipe()

This is the actual set of steps to take to check for and install a program, and
should be defined in your subclass in the C<meet()> method.  If not obvious,
the steps can be "simple" system commands (as is the default) or complex perl.

By default, this base recipe uses the C<system_install()> method.

=cut

sub recipe
{
    my $self = shift;
    my @steps = @_;
    $self->system_install(@steps) unless $self->condition;
}

=head2 system_install()

Use a simple C<system(@command)> function to install the program.

=cut

sub system_install
{
    my $self = shift;
    my @commands = @_;
    for my $cmd (@commands)
    {
        #warn "CMD: @$cmd\n";
        system(@$cmd) == 0 or warn "system @$cmd failed: $?";
    }
}

1;
