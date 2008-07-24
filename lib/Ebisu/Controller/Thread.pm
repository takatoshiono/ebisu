package Ebisu::Controller::Thread;

use strict;
use warnings;
use base 'Catalyst::Controller';

=head1 NAME

Ebisu::Controller::Thread - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 default 

=cut

sub default : Private {
    my ($self, $c) = @_;
    $c->res->status(404);
    $c->res->body('404 Not found');
}

=head2 show

=cut

sub show : LocalRegex('^(\d+)$') {
    my ($self, $c) = @_;
    my $id = $c->req->captures->[0];
    $c->stash->{thread} = $c->model('DBIC::Thread')->find($id);
    unless ($c->stash->{thread}) {
        $c->flash->{notice} = $c->localize('INVALID_THREAD');
        $c->res->redirect($c->uri_for('/'));
    }
}

=head2 create_entry

=cut

sub create_entry : Local {
    my ($self, $c) = @_;

    if ($c->form_submitted) {
        unless ($c->forward('do_create_entry')) {
            $c->stash->{thread} = $c->model('DBIC::Thread')->find($c->req->param('thread_id'));
            $c->stash->{template} = 'thread/show.tt2';
        }
    }
    else {
        $c->res->redirect($c->uri_for('/'));
    }
}

=head2 do_create_entry

=cut

sub do_create_entry : Private {
    my ($self, $c) = @_;

    $c->form(
        name => [['JLENGTH', 0, 32]],
        email => [['JLENGTH', 0, 64]],
        body => [qw/NOT_BLANK/, ['JLENGTH', 0, 4000]],
    );

    unless ($c->form->has_error) {
        my $thread_id = $c->req->param('thread_id');
        my @parts = split /#/, $c->req->param('name');
        my $name = shift @parts;
        my $password = '#' . join q{#}, @parts;
        my $coderef = sub {
            $c->model('DBIC::Entry')->create(
                {
                    thread_id => $thread_id,
                    name => $name || '',
                    trip => $c->model('Trip')->generate($password),
                    email => $c->req->param('email'),
                    body => $c->req->param('body'),
                    clientid => $c->model('ClientId')->generate(),
                    created_at => \'now()',
                }
            );
        };
        eval {
            $c->model('DBIC')->schema->txn_do($coderef);
        };
        if ($@) {
            $c->log->debug($@);
            $c->flash->{notice} = $c->localize('CANNOT_CREATE_ENTRY');
            $c->stash->{error} = 1; # to fill form
            return 0;
        }
        else {
            $c->res->redirect($c->uri_for('/thread', $thread_id));
            return 1;
        }
    }
    return 0;
}

=head1 AUTHOR

ono takatoshi

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
