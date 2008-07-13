#!/usr/bin/perl

# Load testing for PPI::XS

# Tests to make sure that PPI::XS is autoloaded when PPI itself is loaded.

use strict;
BEGIN {
	$|  = 1;
	$^W = 1;
}

use Test::More tests => 12;

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
	is( PPI::Element->significant, 1, 'PPI::Element->significant returns true' );
	is( PPI::Token::Comment->significant, '', 'PPI::Token::Comment->significant return false' );
	is( PPI::Token::Whitespace->significant, '', 'PPI::Token::Whitespace->significant return false' );
	is( PPI::Token::End->significant, '', 'PPI::Token::End->significant returns false' );
}
