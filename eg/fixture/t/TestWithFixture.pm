package TestWithFixture;
use strict;
use warnings;
use 5.010;

use PerlTest;

use File::Basename qw(dirname);
use File::Spec;
use lib dirname(File::Spec->rel2abs(__FILE__));
use FixtureDemo;

sub test_with_fixture {
    my $demo = FixtureDemo->new;
    diag 'test_with_fixture';
    ok __PACKAGE__ eq 'TestWithFixture', 'package is correct';
}

sub test_with_fixture_and_failure {
    my $demo = FixtureDemo->new;
    diag 'test_with_fixture_and_failure';
    ok 0, 'failure';
}

#sub test_with_exception {
#    my $demo = FixtureDemo->new;
#    diag 'test_with_exception';
#    ok 1, 'success';
#    die 'An exception';
#}

1;
