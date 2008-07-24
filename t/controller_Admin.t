use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'Ebisu' }
BEGIN { use_ok 'Ebisu::Controller::Admin' }

ok( request('/admin')->is_success, 'Request should succeed' );


