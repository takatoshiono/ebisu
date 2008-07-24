use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'Ebisu' }
BEGIN { use_ok 'Ebisu::Controller::Logout' }

ok( request('/logout')->is_success, 'Request should succeed' );


