package TestClass;
use strict;
use warnings;
use 5.010;

use base 'PerlTest::Base';
use PerlTest;

sub test_me {
    my ($self) = @_;
    diag 'test_me';
    ok __PACKAGE__ eq 'TestClass', 'package is correct';
    ok ref $self eq 'TestClass';
    ok @_ == 1, 'one parameter passed';
}

sub test_them {
    my ($self) = @_;
    diag 'test_them';
    ok __PACKAGE__ eq 'TestClass', 'package is correct';
    ok ref $self eq 'TestClass';
    ok @_ == 1, 'one parameter passed';
}

1;
