use strict;
use warnings;
require 5.008001;
use ExtUtils::MakeMaker;

my $developer = -f '.gitignore';
ExtUtils::MakeMaker->VERSION(6.98) if $developer;

my %WriteMakefileArgs = (
    NAME                => 'PerlTest',
    VERSION_FROM        => 'lib/PerlTest.pm',
    ABSTRACT_FROM       => 'lib/PerlTest.pm',
    AUTHOR              => 'Gabor Szabo <gabor@szabgab.com>',
    LICENSE             => 'perl_5',

    META_MERGE => {
        'meta-spec' => { version => 2 },
        dynamic_config => 1,
        resources => {
            repository => {
                url => 'https://github.com/szabgab/perltest.git',
                web => 'https://github.com/szabgab/perltest',
                type => 'git',
            },
            bugtracker => {
                web => 'https://github.com/szabgab/perltest/issues',
            },
        },
        x_contributors => [ # add manually, from git shortlog -e -s -n
            'Gabor Szabo <gabor@szabgab.com>',
        ],
    },

    META_ADD => {
        'meta-spec' => { version => 2 },
        prereqs => {
            configure => {
                requires => {
                    'ExtUtils::MakeMaker' => '0',
                },
            },
            runtime => {
                requires => {
                    'perl'                  => '5.008001',
                    'Test2::API'            => '0',
                    'strict'                => '0',
                    'warnings'              => '0',
                },
            },
            test => {
                requires => {
                },
            },
        },
    },
);

my $eumm_version  = eval $ExtUtils::MakeMaker::VERSION;

for (qw(configure build test runtime)) {
    my $key = $_ eq 'runtime' ? 'PREREQ_PM' : uc $_.'_REQUIRES';
    next unless exists $WriteMakefileArgs{META_ADD}{prereqs}{$_}
             or exists $WriteMakefileArgs{$key};
    my $r = $WriteMakefileArgs{$key} = {
        %{$WriteMakefileArgs{META_ADD}{prereqs}{$_}{requires} || {}},
        %{delete $WriteMakefileArgs{$key} || {}},
    };
    defined $r->{$_} or delete $r->{$_} for keys %$r;
}

WriteMakefile(%WriteMakefileArgs);
