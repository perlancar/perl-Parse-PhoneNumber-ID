#!perl

use 5.010;
use strict;
use warnings;
use Log::Any '$log';
use Test::More 0.96;

use Parse::PhoneNumber::ID;

test_parse(
    args   => {},
    status => 200,
    res    => {...},
);

test_extract();

test_format();

done_testing();


