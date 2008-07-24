package Ebisu::Schema::Entry;

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
__PACKAGE__->table("entry");
__PACKAGE__->add_columns(
  "id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "thread_id",
  { data_type => "INT", default_value => "", is_nullable => 0, size => 11 },
  "name",
  { data_type => "VARCHAR", default_value => "", is_nullable => 0, size => 32 },
  "trip",
  { data_type => "CHAR", default_value => "", is_nullable => 0, size => 10 },
  "email",
  { data_type => "VARCHAR", default_value => "", is_nullable => 0, size => 200 },
  "body",
  { data_type => "TEXT", default_value => "", is_nullable => 0, size => 65535 },
  "clientid",
  { data_type => "CHAR", default_value => "", is_nullable => 0, size => 10 },
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
package Ebisu::Schema::Entry;

__PACKAGE__->belongs_to(
    thread => 'Ebisu::Schema::Thread',
    { 'foreign.id' => 'self.thread_id' }
);

sub insert {
    my ($self, @args) = @_;
    $self->next::method(@args);
    $self->thread->update({ updated_at => \'now()' });
    return $self;
}

1;

# End of lines loaded from user-supplied external file 

1;

