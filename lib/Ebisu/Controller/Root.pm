package Ebisu::Controller::Root;

use strict;
use warnings;
use base 'Catalyst::Controller';

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config->{namespace} = '';

=head1 NAME

Ebisu::Controller::Root - Root Controller for Ebisu

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=cut

=head2 default

=cut

sub default : Private {
    my ( $self, $c ) = @_;
    $c->res->status(404);
    $c->res->body('404 Not found');
}

=head2 auto

=cut

sub auto : Private {
    my ($self, $c) = @_;

    if ($c->req->path =~ /^admin/) {
        if (!$c->user_exists) {
            $c->res->redirect($c->uri_for('/login'));
            return 0;
        }
        elsif (!$c->check_user_roles('admin')) {
            $c->flash->{notice} = $c->loc('NOT_ALLOWED_ACTION');
            $c->res->redirect($c->uri_for('/'));
            return 0;
        }
    }

    return 1;
}

=head2 end

Attempt to render a view, if needed.

=cut 

sub end : ActionClass('RenderView') {}

=head2 index

=cut

sub index : Private {
    my ($self, $c) = @_;

    $c->stash->{category_rs} = $c->model('DBIC::Category')->enable_categories();
}

=head2 create_thread

=cut

sub create_thread : Local {
    my ($self, $c) = @_;

    if ($c->form_submitted('confirm')) {
        $c->forward('do_create_thread', [qw/confirm/]);
    }
    elsif ($c->form_submitted('commit')) {
        $c->forward('do_create_thread', [qw/commit/]);
    }

    $c->stash->{category}
        = $c->model('DBIC::Category')->find($c->req->param('category_id'));
    unless ($c->stash->{category}) {
        $c->flash->{notice} = $c->localize('INVALID_CATEGORY');
        $c->res->redirect($c->uri_for('/'));
    }
}

=head2 do_create_thread

=cut

sub do_create_thread : Private {
    my ($self, $c, $action) = @_;

    $c->form(
        title => [qw/NOT_BLANK/, ['JLENGTH', 0, 200]],
        description => [qw/NOT_BLANK/, ['JLENGTH', 0, 400]]
    );

    unless ($c->form->has_error) {
        if ($action eq 'confirm') {
            $c->stash->{template} = 'create_thread_confirm.tt2';
        }
        elsif ($action eq 'commit') {
            my $category_id = $c->req->param('category_id');
            my $coderef = sub {
                my $thread = $c->model('DBIC::Thread')->create(
                    {
                        category_id => $category_id,
                        title => $c->req->param('title'),
                        description => $c->req->param('description'),
                        created_at => \'now()',
                    }
                );
            };
            eval {
                $c->model('DBIC')->schema->txn_do($coderef);
            };
            if ($@) {
                $c->log->debug("failed to create thread: $@");
                $c->flash->{notice} = $c->localize('CANNOT_CREATE_THREAD');
                $c->stash->{template} = 'create_thread_confirm.tt2';
            }
            else {
                $c->flash->{notice} = sprintf(
                    $c->localize('CREATE_THREAD'),
                    $c->req->param('title')
                );
                $c->res->redirect($c->uri_for('/'));
            }
        }
    }
}

=head2 category

=cut

sub category : Local {
    my ($self, $c, $id) = @_;

    $c->stash->{category} = $c->model('DBIC::Category')->find($id);
    $c->stash->{category_rs} = $c->model('DBIC::Category')->enable_categories();
    $c->stash->{thread_rs} = $c->model('DBIC::Thread')->search(
        { category_id => $id },
        { order_by => \'updated_at DESC' }
    );
}

=head1 AUTHOR

ono takatoshi

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
