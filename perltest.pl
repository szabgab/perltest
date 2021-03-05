use strict;
use warnings;
use 5.010;
use Data::Dumper qw(Dumper);
use File::Basename qw(basename);

use lib 't';

my @pairs = collect();
#say Dumper \@pairs;
for my $pair (@pairs) {
    my ($namespace, $tests) = @$pair;
    run($namespace, $tests);
}


sub run {
    my ($namespace, $tests) = @_;
    #say $namespace;
    #say Dumper $tests;

    my $obj;
    if ($namespace->isa('PerlTestBase')) {
        $obj = $namespace->new;
    }
    for my $test (sort @$tests) {
        if ($namespace->isa('PerlTestBase')) {
            $obj->$test;
        } else {
            my $func = "${namespace}::${test}";
            no strict 'refs';
            $func->();
        }
    }
}

sub collect {
    my @modules = glob 't/Test*.pm';
    my @names = map { substr(basename($_), 0, -3) } @modules;
    #print Dumper \@names;
    my @pairs;
    for my $filename (@names) {
        #say $filename;
        eval "use $filename";
        die $@ if $@;
        #print Dumper \%INC;

        my @test_functions;
        no strict 'refs';
        for my $name (keys %{"${filename}::"}) {
            #say $name;
            if ($name =~ /^test_.+/) {
                push @test_functions, $name;
            }
        }

        #print Dumper \@test_functions;
        push @pairs, [$filename, \@test_functions];
    }
    return @pairs;
}


