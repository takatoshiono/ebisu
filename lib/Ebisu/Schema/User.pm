package Ebisu::Schema::User;

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
__PACKAGE__->table("user");
__PACKAGE__->add_columns(
  "id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "username",
  { data_type => "VARCHAR", default_value => "", is_nullable => 0, size => 32 },
  "password",
  { data_type => "VARCHAR", default_value => "", is_nullable => 0, size => 40 },
  "status",
  { data_type => "ENUM", default_value => "", is_nullable => 0, size => 8 },
  "updated_at",
  {
    data_type => "TIMESTAMP",
    default_value => "CURRENT_TIMESTAMP",
    is_nullable => 0,
    size => 14,
  },
  "created_at",
  { data_type => "DATETIME", default_value => "", is_nullable => 0, size => 19 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("username", ["username"]);
# These lines loaded from user-supplied external file: 
package Ebisu::Schema::User;

__PACKAGE__->has_many(
    user_roles => 'Ebisu::Schema::UserRole',
    { 'foreign.user_id' => 'self.id' }
);

__PACKAGE__->many_to_many(
    roles => 'user_roles', 'role'
);

1;

# End of lines loaded from user-supplied external file 

1;

