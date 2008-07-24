#!/usr/bin/perl
use strict;
use warnings;

use FindBin;
use File::Spec;
use lib File::Spec->catfile( $FindBin::Bin, qw/.. schema lib/ );

use DBIx::Class::Schema::Loader qw/make_schema_at/;

die unless @ARGV;

make_schema_at(
    'Ebisu::Schema',
    {   components     => ['ResultSetManager', 'InflateColumn::DateTime'],
        dump_directory => File::Spec->catfile( $FindBin::Bin, '..', 'lib' ),
        dump_overwrite => 1,
        debug => 1,
    },
    \@ARGV,
);

