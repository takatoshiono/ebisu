package Ebisu::Schema::UserRole;

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
__PACKAGE__->table("user_role");
__PACKAGE__->add_columns(
  "id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "user_id",
  { data_type => "INT", default_value => "", is_nullable => 0, size => 11 },
  "role_id",
  { data_type => "INT", default_value => "", is_nullable => 0, size => 11 },
);
__PACKAGE__->set_primary_key("id");
# These lines loaded from user-supplied external file: 
package Ebisu::Schema::UserRole;

__PACKAGE__->belongs_to(
    user => 'Ebisu::Schema::User',
    { 'foreign.id' => 'self.user_id' }
);

__PACKAGE__->belongs_to(
    role => 'Ebisu::Schema::Role',
    { 'foreign.id' => 'self.role_id' }
);

1;

# End of lines loaded from user-supplied external file 

1;

