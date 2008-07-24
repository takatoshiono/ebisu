package Ebisu::Model::Trip;

use strict;
use warnings;
use base 'Catalyst::Model';

=head1 NAME

Ebisu::Model::Trip - Catalyst Model

=head1 DESCRIPTION

Catalyst Model.

=cut

=head1 METHODS

=head2 generate

    my $trip = $c->model('Trip')->generate('#abc');

=cut

sub generate {
    my ($self, $password) = @_;

    return '' unless $password;
    return '' unless $password =~ /^#/;

    $password = substr($password, 1);

    my $salt = substr($password.'H.', 1, 2);
    $salt =~ s/[^\.-z]/\./go;
    $salt =~ tr/:;<=>?@[\\]-_`/ABCDEFGabcdef/;

    my $trip = crypt($password, $salt);
    $trip = substr($trip, -10);

    return $trip;
}

=head1 AUTHOR

ono takatoshi

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
