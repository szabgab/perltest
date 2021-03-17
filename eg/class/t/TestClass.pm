package TestClass;
use strict;
use warnings;
use 5.010;

use base 'PerlTest::Base';
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

sub setup_class {
    my ($self) = @_;
    diag 'setup_class: ' . ref($self);
}

sub teardown_class {
    my ($self) = @_;
    diag 'teardown_class: ' . ref($self);
}

sub setup_method {
    my ($self) = @_;
    diag 'setup_method ' . ref($self);
}

sub teardown_method {
    my ($self) = @_;
    diag 'teardown_method ' . ref($self);
}


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
