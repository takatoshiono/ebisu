package Ebisu::Utils;
use strict;
use warnings;

sub form_submitted {
    my $c = shift;
    my $name = shift || 'submit';
    return ($c->req->method eq 'POST' and $c->req->param($name));
}

1;

