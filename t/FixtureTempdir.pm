package FixtureTempdir;
use strict;
use warnings;
use 5.010;
use File::Temp qw(tempdir);

our $NAME = '$tmpdir';

sub new {
    my ($class) = @_;
    return tempdir( CLEANUP => 1 );
}

1;
