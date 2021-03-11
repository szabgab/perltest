package TestWithTempdir;
use strict;
use warnings;

use PerlTest;
use File::Temp qw(tempdir);

sub test_with_tempdir {
    my $tmpdir = tempdir( CLEANUP => 1 );
    diag "test_with_tempdir $tmpdir";
    ok __PACKAGE__ eq 'TestWithTempdir', 'package is correct';
    ok @_ == 0, 'zero parameter passed';
}


1;

