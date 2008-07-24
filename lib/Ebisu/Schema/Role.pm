package Ebisu::Schema::Role;

# Created by DBIx::Class::Schema::Loader v0.03012 @ 2007-07-24 00:31:47

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components(
  "ResultSetManager",
  "InflateColumn::DateTime",
  "PK::Auto",
  "Core",
);
__PACKAGE__->table("role");
__PACKAGE__->add_columns(
  "id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "rolename",
  { data_type => "VARCHAR", default_value => "", is_nullable => 0, size => 32 },
);
__PACKAGE__->set_primary_key("id");
# These lines loaded from user-supplied external file: 
package Ebisu::Schema::Role;

__PACKAGE__->has_many(
    user_roles => 'Ebisu::Schema::UserRole',
    { 'foreign.role_id' => 'self.id' }
);

__PACKAGE__->many_to_many(
    users => 'user_roles', 'user'
);

1;

# End of lines loaded from user-supplied external file 

1;

