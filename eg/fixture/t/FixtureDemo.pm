package FixtureDemo;
use strict;
use warnings;
use 5.010;

sub new {
    my ($class) = @_;
    say 'setup part of the FixtureDemo';
    return bless {}, $class;
}

DESTROY {
    my ($self) = @_;
    say 'teardown part of the FixtureDemo';
}

1;
