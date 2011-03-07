#!perl

use 5.010;
use strict;
use warnings;
use Log::Any '$log';
use Test::More 0.96;

use Parse::PhoneNumber::ID;

my %data = (
    # numbers that are too short
    # numbers that are too long
    # non-indonesian number (+65 xx)

    # list of known operators
    # list of known area codes
    '0856 123 456' => {},
    '0856 123 4567' => {},
    '0856 1234 5678' => {},
    '+62 856 123456' => {},
    '62 856 123456' => {},
    # default area code: 7123 4567 -> 022 7123 4567

    # formatting: 0856-123-4567
    # formatting: 0 8 5 6 1 2 3 4 5 6 7 8
    # formatting: 0-8-5-6-1-2-3-4-5-6-7-8
    # formatting: two numbers, sequential, shorthand: 7123 4567/8
    # formatting: two numbers, sequential, shorthand: 7123 4567 / 68
    # formatting: words: nol (de)lapan limaenamsatuduatiga empat lima enam

    # sample texts (| = \n):
    #hny 50rbSpa&Massage,Sunda 71|NewTeraphist+Room,91641176
    #NbDelC2D=2,9AcerAspire+Wbca|m+DVDRW=2,3 T.082115768730
    #APV.T:022-73999999/91819999
    #WIDITOUR2005813-2005814
    #Drop Max 6Org 400Rb:7OOOO9661        <-- pake capital O, not zero
    #Hub:Hp:0813 9450 6959
    #MRH,GRS T.7 2 3 2 5 7 3
    #MM-A. Yani221 KavB12-7276756
    #HPL Mimik5211262/0818424693
    #022--xxxxxxx (-- pake em dash)
    #T:7041.0835-0812.8456.3465
    #t.xxxxxxxx
    #T:022-70362090-08122021027
    #N.EYES & MP320/BMW/JAZZ/|INV/AVZ/APV:08122121135
    #0813.8080|1549;BANDUNG/022-72249239
    #Soekarno Hatta 45-61151901
    # Foo 750/1130|71123030    <-- 750/1130 is price

    # strategy for extract: use several regex/iterations, from strictest (and
    # find only at the bottom lanes, for classified ads) to looser and looser.
    # stop when max number of wanted numbers are reached. or only search using
    # some regexes.
);

test_parse(
    args   => {},
    status => 200,
    res    => {...},
);

test_extract();

test_format();

done_testing();


