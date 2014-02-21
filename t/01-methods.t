#!perl
use Test::More;

use_ok 'App::Provision::Tiny';

my $x = eval { App::Provision::Tiny->new };
isa_ok $x, 'App::Provision::Tiny';
ok !$@, 'created with no arguments';
my $y = $x->{foo};
is $y, 'bar', "foo: $y";

$x = App::Provision::Tiny->new(
    foo => 'Zap!',
);
my $y = $obj->{foo};
like $y, qr/zap/i, "foo: $y";

done_testing();
