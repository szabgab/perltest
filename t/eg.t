use strict;
use warnings;

use Test::More;
use Capture::Tiny qw(capture);
use Path::Tiny qw(path);
use File::Spec;


opendir my $dh, 'eg';
my @dirs = grep { $_ ne '.' and $_ ne '..' } readdir $dh;
close $dh;

for my $dir (@dirs) {
    chdir File::Spec->catdir('eg', $dir);
    my ($out, $err, $exit) = capture {
        system "$^X -I../../lib t/perltest.t";
    };
    $exit /= 256;
    my $expected_exit = path('expected.exit')->slurp_utf8;
    chomp $expected_exit;
    is $exit, $expected_exit, "exit for $dir";
    my $expected_out = path('expected.out')->slurp_utf8;
    is $out, $expected_out, "STDOUT for $dir";
    my $expected_err = path('expected.err')->slurp_utf8;
    is $err, $expected_err, "STDERR for $dir";
    chdir '../..';
}

done_testing;

