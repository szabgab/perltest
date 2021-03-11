package TestWithFixture;
use strict;
use warnings;
use 5.010;

use PerlTest;
use FixtureDataBase;

sub test_database {
    my $database = FixtureDataBase->new;
    diag 'test_database';
    ok __PACKAGE__ eq 'TestWithFixture', 'package is correct';
    # use the $database
}


1;

