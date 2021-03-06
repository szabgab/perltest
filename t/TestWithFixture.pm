package TestWithFixture;
use strict;
use warnings;
use 5.010;
use feature 'signatures';
no warnings 'experimental::signatures';

use PerlTest;

sub test_database($database) {
    diag 'test_database';
    ok __PACKAGE__ eq 'TestWithFixture', 'package is correct';
    # use the $database
}


1;

