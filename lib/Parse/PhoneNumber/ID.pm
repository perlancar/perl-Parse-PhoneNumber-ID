package Parse::PhoneNumber::ID;
# ABSTRACT: Parse Indonesian phone numbers

use 5.010;
use strict;
use warnings;
use Log::Any '$log';

require Exporter;
our @ISA       = qw(Exporter);
our @EXPORT_OK = qw(parse_id_phone extract_id_phones format_id_phone);

our %SPEC;

$SPEC{parse_id_phone} = {
    summary     => 'Parse string containing phone number',
    description => <<'_',


_
    args        => {
        text => ['str*' => {
        }],
        default_area_code => ['str' => {
        }],
    },
};
sub parse_id_phone {
    my %args = @_;

    my $res = extract_id_phones(%args, max => 1);
    if ($res->[0] != 200) {
        return $res;
    } elsif ($res->[0] == 200 && !@{$res->[2]}) {
        return [500, "There are no phone numbers in text"];
    } else {
        return [200, "OK", $res->[2][0]];
    }
}

$SPEC{extract_id_phones} = {
    summary     => 'Extract phone numbers from text',
    description => <<'_',

This is just like parse_id_phone(), except that it finds more than one numbers
in text.

_
    args        => {
    },
};
sub extract_id_phones {
}

$SPEC{format_id_phone} = {
    summary     => 'Pretty-print parsed phone number',
    description => <<'_',
_
    args        => {
    },
};
sub format_id_phone {
}

1;
__END__

=head1 SYNOPSIS

 use 5.010;
 use Parse::PhoneNumber::ID qw(parse_id_phone
                               extract_id_phones
                               format_id_phone);

 my $res = parse_id_phone(number => '7123 4567', default_area_code=>'021');
 $res->[0] == 200 or die "Can't parse phone number";
 my $phone = $res->[2];
 dd $phone; # { raw => '7123 4567', is_cell => 1, cell_op => 'telkom',
            #   cell_prod => 'flexi', area_code => '021',
            #   area => 'jakarta', local_num => '71234567',
            #   country=>'Indonesia', country_code=>'62', ext=>undef, }

 $res = extract_id_phones(text => 'some text containing phone number(s):
                                   0812 2345 6789, +62-22-91234567');
 my $phones = $res->[2];
 say "There are ", scalar(@$phones), "phone number(s) found in text";
 for (@$phones) { say format_id_phone($_)->[2] }

=head1 DESCRIPTION

This module can parse Indonesian phone numbers. It understands the list of known
area codes and cellular operators, as well as other information.

This module uses L<Log::Any> logging framework, so you can use something like
L<Log::Any::App> to easily show more logging output during debugging.

This module uses L<Sub::Spec> specs for its functions.


=head1 SEE ALSO

L<Parse::PhoneNumber>
