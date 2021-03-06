package FixtureDataBase;
use strict;
use warnings;
use 5.010;

our $NAME = '$database';

sub new {
    my ($class) = @_;
    say 'set up database, return object represnting it.';
    return bless {}, $class;
}

DESTROY {
    my ($self) = @_;
    say 'remove database';
}

1;
