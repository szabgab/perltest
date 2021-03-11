package TestXUnit;
use strict;
use warnings;
use 5.010;

use PerlTest;

sub setup_module {
    diag 'setup_module';
}

sub teardown_module {
    diag 'teardown_module';
}

sub setup_function {
    diag 'setup_function';
}

sub teardown_function {
    diag 'teardown_function';
}

sub test_me {
    diag 'test_me';
    ok __PACKAGE__ eq 'TestXUnit', 'package is correct';
    ok not(@_), 'no parameters passed';
}

sub test_them {
    diag 'test_them';
    ok __PACKAGE__ eq 'TestXUnit', 'package is correct';
    ok not(@_), 'no parameters passed';
}

1;
