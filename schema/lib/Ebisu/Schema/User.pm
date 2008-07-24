package Ebisu::Schema::User;

__PACKAGE__->has_many(
    user_roles => 'Ebisu::Schema::UserRole',
    { 'foreign.user_id' => 'self.id' }
);

__PACKAGE__->many_to_many(
    roles => 'user_roles', 'role'
);

1;

