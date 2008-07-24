package Ebisu::Schema::Role;

__PACKAGE__->has_many(
    user_roles => 'Ebisu::Schema::UserRole',
    { 'foreign.role_id' => 'self.id' }
);

__PACKAGE__->many_to_many(
    users => 'user_roles', 'user'
);

1;

