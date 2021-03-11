use strict;
use warnings;

use Test::More;
use Capture::Tiny qw(capture);
use Path::Tiny qw(path);
use File::Spec;


for my $dir (qw(a)) {
    chdir File::Spec->catdir('eg', $dir);
    my ($out, $err, $exit) = capture {
        system "$^X -I../../lib perltest.t";
    };
    is $exit, 0;
    my $expected_out = path('expected.out')->slurp_utf8;
    is $out, $expected_out;
    my $expected_err = path('expected.err')->slurp_utf8;
    is $err, $expected_err;
    chdir '../..';
}

done_testing;

