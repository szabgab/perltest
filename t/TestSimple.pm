package TestSimple;
use strict;
use warnings;
use 5.010;

sub test_me {
    say 'test_me in ' . __PACKAGE__;
}

sub test_them {
    say 'test_them in ' . __PACKAGE__;
}

1;
