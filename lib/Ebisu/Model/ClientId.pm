package Ebisu::Model::ClientId;

use strict;
use warnings;
use base 'Catalyst::Model';
use DateTime;

=head1 NAME

Ebisu::Model::ClientId - Catalyst Model

=head1 DESCRIPTION

Catalyst Model.

=head1 METHODS

=head2 generate

=cut

sub generate {
    my $self = shift;

    my $ip_address = $ENV{REMOTE_ADDR};
    $ip_address =~ s/\.//g;
    my $date = DateTime->now(time_zone => 'Asia/Tokyo')->strftime('%Y%m%d');
    my $str = $date + $ip_address;

    my $salt = substr($str, 1, 2);
    $salt =~ s/[^\.-z]/\./go;
    $salt =~ tr/:;<=>?@[\\]-_`/ABCDEFGabcdef/;

    my $clientid = crypt($str, $salt);
    $clientid = substr($clientid, -8);

    return $clientid;
}

=head1 AUTHOR

ono takatoshi

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
