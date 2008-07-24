package Ebisu::Controller::Admin::Category;

use strict;
use warnings;
use base 'Catalyst::Controller';

=head1 NAME

Ebisu::Controller::Admin::Category - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index 

=cut

sub index : Private {
    my ( $self, $c ) = @_;

    $c->res->redirect($c->uri_for('/admin/category/list'));
}

=head2 list

=cut

sub list : Local {
    my ($self, $c) = @_;

    $c->stash->{category_rs} = $c->model('DBIC::Category')->search({},
        {
            order_by => 'id DESC',
        }
    );
}

=head2 create

=cut

sub create : Local {
    my ($self, $c) = @_;

    if ($c->form_submitted) {
        $c->forward('do_create');
    }
}

=head2 do_create

=cut

sub do_create : Private {
    my ($self, $c) = @_;

    $c->form(
        name => [qw/NOT_BLANK/, [qw/JLENGTH 0 200/], ['DBIC_UNIQUE', $c->model('DBIC::Category'), 'name']]
    );
    unless ($c->form->has_error) {
        $c->model('DBIC::Category')->create(
            {
                name => $c->req->param('name'),
                created_at => DateTime->now(time_zone => 'Asia/Tokyo'),
            }
        );
        $c->res->redirect($c->uri_for('/admin/category/list'));
    }
}

=head2 edit

=cut

sub edit : Local {
    my ($self, $c, $id) = @_;

    if ($c->form_submitted) {
        $c->forward('do_edit');
    }
    else {
        $c->stash->{category} = $c->model('DBIC::Category')->find($id);
        unless ($c->stash->{category}) {
            $c->flash->{notice} = $c->localize('INVALID_CATEGORY');
            $c->res->redirect($c->uri_for('/admin/category/list'));
        }
    }
}

=head2 do_edit

=cut

sub do_edit : Private {
    my ($self, $c, $id) = @_;

    $c->form(
        name => [qw/NOT_BLANK/, [qw/JLENGTH 0 200/]],
        {unique => [qw/id name/]} => [['DBIC_UNIQUE', $c->model('DBIC::Category'), qw/!id name/]]
    );
    unless ($c->form->has_error) {
        my $id = $c->req->param('id');
        my $name = $c->req->param('name');

        if (my $category = $c->model('DBIC::Category')->find($id)) {
            $category->name($name);
            $category->update();
            $c->res->redirect($c->uri_for('/admin/category/list'));
        }
        else {
            $c->set_invalid_form(id => 'NOT_EXIST');
        }
    }
}

=head2 delete

=cut

sub delete : Local {
    my ($self, $c, $id) = @_;

    if ($c->form_submitted) {
        if (my $name = $c->forward('do_delete')) {
            $c->flash->{notice} = sprintf($c->localize('DELETE_CATEGORY'), $name);
            $c->res->redirect($c->uri_for('/admin/category/list'));
        }
        else {
            $c->flash->{notice} = $c->localize('CANNOT_DELETE_CATEGORY');
            $c->res->redirect($c->uri_for('/admin/category/list'));
        }
    }
    else {
        $c->stash->{category} = $c->model('DBIC::Category')->find($id);
        unless ($c->stash->{category}) {
            $c->flash->{notice} = $c->localize('INVALID_CATEGORY');
            $c->res->redirect($c->uri_for('/admin/category/list'));
        }
    }
}

=head2 do_delete

=cut

sub do_delete : Private {
    my ($self, $c, $id) = @_;

    my $category = $c->model('DBIC::Category')->find($id);
    if ($category) {
        $category->delete;
        return $category->name;
    }
}

=head1 AUTHOR

ono takatoshi

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
