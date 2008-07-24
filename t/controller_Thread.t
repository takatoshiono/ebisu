use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'Ebisu' }
BEGIN { use_ok 'Ebisu::Controller::Thread' }

ok( request('/thread')->is_success, 'Request should succeed' );


