package Ebisu::Schema::Category;

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
__PACKAGE__->table("category");
__PACKAGE__->add_columns(
  "id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "name",
  { data_type => "VARCHAR", default_value => "", is_nullable => 0, size => 200 },
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
__PACKAGE__->add_unique_constraint("name", ["name"]);
# These lines loaded from user-supplied external file: 
package Ebisu::Schema::Category;

__PACKAGE__->has_many(
    threads => 'Ebisu::Schema::Thread',
    { 'foreign.category_id' => 'self.id' },
    { order_by => 'updated_at DESC' }
);

sub enable_categories : ResultSet {
    shift->search({}, { order_by => 'updated_at DESC' });
}

1;

# End of lines loaded from user-supplied external file 

1;

