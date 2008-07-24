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

