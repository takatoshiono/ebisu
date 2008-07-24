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

