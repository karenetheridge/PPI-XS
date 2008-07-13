#!/usr/bin/perl

# content() testing for PPI::XS

use strict;
BEGIN {
	$|  = 1;
	$^W = 1;
}

use Test::More tests => 4 + 2 * 5;

# Load PPI
$PPI::XS_DISABLE = 1;
use_ok( 'PPI' );
ok( ! $PPI::XS::VERSION, 'PPI::XS not loaded' );

# Run the main tests
tests();

# Now load the XS versions
$PPI::XS_DISABLE = '';
use_ok( 'PPI::XS' );
ok( $PPI::XS::VERSION, 'PPI::XS is loaded' );

# Run the tests again
tests();

sub tests {
	my $Token = PPI::Token::Whitespace->new( ' ' );
	is( $Token->content, ' ', 'content' );
	is( $Token->set_content(' '), ' ', 'set_content' );
	is( $Token->content, ' ', 'content' );
	is( $Token->add_content('foo'), ' foo', 'set_content' );
	is( $Token->content, ' foo', 'content' );
}
