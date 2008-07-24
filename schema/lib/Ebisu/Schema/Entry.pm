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

