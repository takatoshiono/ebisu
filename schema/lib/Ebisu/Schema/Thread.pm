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

