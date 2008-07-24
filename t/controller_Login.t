use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'Ebisu' }
BEGIN { use_ok 'Ebisu::Controller::Login' }

ok( request('/login')->is_success, 'Request should succeed' );


