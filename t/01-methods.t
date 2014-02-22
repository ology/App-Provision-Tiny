#!perl
use Test::More;

use_ok 'App::Provision::Tiny';

my $x = eval { App::Provision::Tiny->new };
isa_ok $x, 'App::Provision::Tiny';

done_testing();
