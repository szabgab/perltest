package TestSimple;
use strict;
use warnings;
use 5.010;

use PerlTest;

sub test_me {
    diag 'test_me';
    ok __PACKAGE__ eq 'TestSimple', 'package is correct';
    ok not(@_), 'no parameters passed';
}

sub test_them {
    diag 'test_them';
    ok __PACKAGE__ eq 'TestSimple', 'package is correct';
    ok not(@_), 'no parameters passed';
}

1;
