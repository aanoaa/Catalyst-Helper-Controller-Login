package Catalyst::Helper::Controller::Login;
# ABSTRACT: a short description for Catalyst::Helper::Controller::Login

use strict;

=head1 SYNOPSIS

    script/create.pl controller NAME Catalyst::Helper::Controller::Login

=head1 DESCRIPTION

Helper for Catalyst::Helper::Controller::Login Controller.

=head1 METHODS

=head2 mk_compclass

Make Component Class.

=cut

sub mk_compclass {
    my ( $self, $helper ) = @_;
    my $file = $helper->{file};
    $helper->render_file( 'compclass', $file );
}

=head2 mk_comptest

Makes test for Controller.

=cut

sub mk_comptest {
    my ( $self, $helper ) = @_;
    my $test = $helper->{'test'};
    $helper->render_file( 'comptest', $test );
}

=head1 SEE ALSO

L<Catalyst::Helper>

=cut

1;

# PodWeaver complaint 'literal string' about '__DATA__',but mk_XXX subs should have it.
__DATA__

__compclass__
package [% class %];
# ABSTRACT: [% class %]
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

[% class %] - Catalyst controller.

=head1 METHODS

=head2 index

[% class %] index

=cut

sub index :Path :Args(0) {
    my ($self, $c) = @_;
    # do stuff here
}

=head1 SEE ALSO

L<[% app %]>

=head1 AUTHOR

[% author %]

=head1 LICENSE

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

__PACKAGE__->meta->make_immutable;

1;

__comptest__
use strict;
use warnings;
use Test::More qw/no_plan/;
use HTTP::Request::Common;
BEGIN { use_ok 'Catalyst::Test', '[% app %]' }

my ($req, $res);
my $cookie;

{
    $req = GET('/');
    $res = request($req);
    ok( $res->is_success, 'successful response' );
}
