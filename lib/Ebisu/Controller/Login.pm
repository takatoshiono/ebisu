package Ebisu::Controller::Login;

use strict;
use warnings;
use base 'Catalyst::Controller';

=head1 NAME

Ebisu::Controller::Login - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index 

=cut

sub index : Private {
    my ( $self, $c ) = @_;

    if ($c->form_submitted) {
        $c->forward('do_login');
    }
}

=head2 do_login

=cut

sub do_login : Private {
    my ($self, $c) = @_;

    my $username = $c->req->param('username');
    my $password = $c->req->param('password');

    if ($c->authenticate({ username => $username,
                           password => $password,
                           status   => 'enabled', })) {
        $c->flash->{notice} = undef;
        $c->res->redirect($c->uri_for('/'));
    }
    else {
        $c->flash->{notice} = $c->localize('CANNOT_LOGIN');
        $c->stash->{error} = 1;
    }
}

=head1 AUTHOR

ono takatoshi

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
