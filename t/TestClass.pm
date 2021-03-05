package TestClass;
use strict;
use warnings;
use 5.010;

use base 'PerlTestBase';

sub test_me {
    my ($self) = @_;
    say "test_me $self in " . __PACKAGE__;
}

sub test_them {
    my ($self) = @_;
    say "test_them $self in " . __PACKAGE__;
}

1;
