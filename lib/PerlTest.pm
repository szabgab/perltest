package PerlTest;
use strict;
use warnings;
use 5.010;

our $VERSION = '0.01';

use Data::Dumper qw(Dumper);
use File::Basename qw(basename);
use Exporter qw(import);
use Test2::API qw(context);

use lib 't';

our @EXPORT = qw(ok diag);

sub diag ($) {
    my ($text) = @_;
    my $ctx = context();
    $ctx->diag($text);
    $ctx->release;
}

sub ok($;$) {
    my ($bool, $name) = @_;
    my $ctx = context();
    $ctx->ok($bool, $name);
    $ctx->release;
    return $bool;
}

sub runtests {
    my $modules = collect();
    #say Dumper \@pairs;
    for my $namespace (sort keys %$modules) {
        run($namespace, $modules->{$namespace});
    }
    done_testing();
}

sub run_fixture {
    my ($namespace, $mode) = @_;
    no strict 'refs';
    if (exists ${"${namespace}::"}{$mode}) {
        my $func = "${namespace}::${mode}";
        $func->();
    }
}

sub run {
    my ($namespace, $details) = @_;
    #say $namespace;

    my $obj;
    if ($namespace->isa('PerlTest::Base')) {
        $obj = $namespace->new;
    } else {
        run_fixture($namespace, 'setup_module');
    }

    for my $test (sort @{ $details->{tests} }) {
        if ($namespace->isa('PerlTest::Base')) {
            $obj->$test;
        } else {
            run_fixture($namespace, 'setup_function');
            my $func = "${namespace}::${test}";
            #print "params: '@params'\n";
            no strict 'refs';
            $func->();
            run_fixture($namespace, 'teardown_function');
        }
    }

    if ($namespace->isa('PerlTest::Base')) {
    } else {
        run_fixture($namespace, 'teardown_module');
    }
}


sub done_testing {
    my $ctx = context();
    $ctx->done_testing;
    $ctx->release;
}

sub collect {
    # TODO search recursively
    my @modules = glob 't/Test*.pm';
    my @names = map { substr(basename($_), 0, -3) } @modules;
    #print Dumper \@names;
    my %parsed;
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
        $parsed{$filename} = {
            tests => \@test_functions,
        };
    }
    return \%parsed;
}

1;

=head1 NAME

PerlTest - a testing library for Perl that provide xUnit and other fixture capabilities

=head1 SYNOPSIS

Create a tests script in the t/ directory with the following content:

    use strict;
    use warnings;
    use PerlTest;
    PerlTest::runtests();

Then each test file is going to me a module called that has a name starting with the word Test e.g.: t/TestSimple.pm

    package TestSimple;
    use strict;
    use warnings;

    use PerlTest;

    sub test_me {
        diag 'test_me';
        ok __PACKAGE__ eq 'TestSimple', 'package is correct';
    }

    sub test_them {
        diag 'test_them';
        ok __PACKAGE__ eq 'TestSimple', 'package is correct';
        ok not(@_), 'no parameters passed';
    }

    1;

When running `prove` it will run each one of the test functions, that is each function that has a prefix test_.

=head1 EXAMPLES

In order to see examples visit the `eg` folder of the L<GitHub repository|https://github.com/szabgab/PerlTest> of the project.

Probably the simplest test-case is in the C<eg/plain> directory.

xUnit style fixtures in C<eg/xunit>:

=over 4

=item setup_module

Runs once before any of test function.

=item teardown_module

Runs once after all the test functions were executed.

=item setup_function

Runs once before evey test function.

=item teardown_function

Runs once after every test function.

=back

Object Orinted test writing, see the C<eg/class> directory.


=head1 LICENCE

Copyright 2021 Gabor Szabo, All Rights Reserved.

This program is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

=cut


