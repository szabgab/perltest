package TestInject;
use strict;
use warnings;
use 5.020;
use feature 'signatures';
no warnings 'experimental::signatures';

use PerlTest;

sub test_with_injection($tmpdir) {
    diag "test_with_injection $tmpdir";
    ok __PACKAGE__ eq 'TestInject', 'package is correct';
    ok @_ == 1, 'one parameter passed';
}


1;

