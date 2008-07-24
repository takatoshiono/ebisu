use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'Ebisu' }
BEGIN { use_ok 'Ebisu::Controller::Admin::Category' }

ok( request('/admin/category')->is_success, 'Request should succeed' );


