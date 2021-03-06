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


sub run {
    my ($namespace, $details) = @_;

    my $obj;
    if ($namespace->isa('PerlTest::Base')) {
        $obj = $namespace->new;
    }
    for my $test (sort @{ $details->{tests} }) {
        if ($namespace->isa('PerlTest::Base')) {
            $obj->$test;
        } else {
            my $func = "${namespace}::${test}";
            my $sigs = get_signature(\&$func);
            #print Dumper $sigs;
            no strict 'refs';
            my @params;
            for my $sig (@$sigs) {
                if ($sig eq '$tmpdir') {
                    use File::Temp qw(tempdir);
                    my $dir = tempdir( CLEANUP => 1 );
                    push @params, $dir;
                }
            }
            $func->(@params);
        }
    }
}

# Based on https://stackoverflow.com/questions/63836449/how-do-i-get-the-signature-of-a-subroutine-in-runtime
sub get_signature {
    my ($code) = @_;

    use B::Deparse;
    my $source = B::Deparse->new->coderef2text($code);
    #print $source;

    my @source = split /\n/, $source;
    #if ($source[2] =~ /use feature 'signatures'/ &&
    #        $source[3] =~ /Too many arguments/ &&
    #        $source[4] =~ /Too few arguments/) {
    my @signature = ();
    for my $row (@source) {
        my ($sig) = $row =~ /my (\W\w+) = /;
        push @signature, $sig if $sig;
    }
    #return "Signature is (", join(",",@signature), ")\n";
    return \@signature;
    die 'Could not get the signature';
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

PerlTest - a testing library for perl similar to pytest

=head1 SYNOPSIS

For exameplslook in the t/ directory.

=head1 LICENCE

Copyright 2021 Gabor Szabo, All Rights Reserved.

This program is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

=cut


