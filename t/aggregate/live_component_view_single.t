#!perl

use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/../lib";

our $iters;

BEGIN { $iters = $ENV{CAT_BENCH_ITERS} || 1; }

use Test::More tests => 3*$iters;
use Catalyst::Test 'TestAppOneView';

if ( $ENV{CAT_BENCHMARK} ) {
    require Benchmark;
    Benchmark::timethis( $iters, \&run_tests );
}
else {
    for ( 1 .. $iters ) {
        run_tests();
    }
}

sub run_tests {
    {
        is(get('/view_by_name?view=Dummy'), 'TestAppOneView::View::Dummy',
            '$c->view("name") returns blessed instance');
        is(get('/view_no_args'), 'TestAppOneView::View::Dummy',
            '$c->view() returns blessed instance');
    }
}