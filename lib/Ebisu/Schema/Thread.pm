package Ebisu::Schema::Thread;

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
__PACKAGE__->table("thread");
__PACKAGE__->add_columns(
  "id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "category_id",
  { data_type => "INT", default_value => "", is_nullable => 0, size => 11 },
  "title",
  { data_type => "VARCHAR", default_value => "", is_nullable => 0, size => 200 },
  "description",
  { data_type => "TEXT", default_value => "", is_nullable => 0, size => 65535 },
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
# These lines loaded from user-supplied external file: 
package Ebisu::Schema::Thread;

__PACKAGE__->belongs_to(
    category => 'Ebisu::Schema::Category',
    { 'foreign.id' => 'self.category_id' },
);
__PACKAGE__->has_many(
    entries => 'Ebisu::Schema::Entry',
    { 'foreign.thread_id' => 'self.id' },
    { order_by => 'id ASC' }
);

sub insert {
    my ($self, @args) = @_;
    $self->next::method(@args);
    $self->category->update({ updated_at => \'now()' });
    return $self;
}

1;

# End of lines loaded from user-supplied external file 

1;

