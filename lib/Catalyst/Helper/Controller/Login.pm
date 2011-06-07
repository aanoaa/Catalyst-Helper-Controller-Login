package Catalyst::Helper::Controller::Login;
# ABSTRACT: a short description for Catalyst::Helper::Controller::Login

use strict;

=head1 SYNOPSIS

    script/*_create.pl controller Login Login

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
    my $test = $helper->{test};
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
# ABSTRACT: Catalyst Controller
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 DESCRIPTION

Catalyst Controller for Authetification and Session Store.

=head1 METHODS

=head2 index

Supply input form as HTML.

if supplied POST request with params,
using it as authenticate.

redirect to root index if authenticate successfully.

=cut

sub index :Path :Args(0) {
    my ($self, $c) = @_;
    if ( $c->req->method eq 'POST' && $c->form->has_error ) {
        $c->detach;
    }

    my $username = $c->req->params->{username};
    my $password = $c->req->params->{password};

    if ($c->authenticate({ user_id => $username, user_pw => $password })) {
        $c->response->redirect($c->uri_for('/'));
        return;
    }
}

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
