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
  $app->foo;

  # On the command line:
  > provis foo

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

    # Set defaults.
    $self->{system} ||= 'osx';
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
is to be redefined in your subclass.  If not obvious, they can be "simple"
system commands, complex perl or a combination thereof.

=cut

sub recipe
{
    my $self = shift;
    my @steps = @_;
    $self->system_install(@steps) unless $self->condition;
}

=head2 system_install()

Use the C<system()> function to install, inside your subclass method.

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
