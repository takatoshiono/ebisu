package Ebisu::Controller::Logout;

use strict;
use warnings;
use base 'Catalyst::Controller';

=head1 NAME

Ebisu::Controller::Logout - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index 

=cut

sub index : Private {
    my ( $self, $c ) = @_;

    $c->logout;
    $c->flash->{notice} = $c->localize('LOGGED_OUT');
    $c->res->redirect($c->uri_for('/'));
}


=head1 AUTHOR

ono takatoshi

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
