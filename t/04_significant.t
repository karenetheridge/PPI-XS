#!/usr/bin/perl -w

# Load testing for PPI::XS

# Tests to make sure that PPI::XS is autoloaded when PPI itself is loaded.

use strict;
use lib ();
use UNIVERSAL 'isa';
use File::Spec::Functions ':ALL';
BEGIN {
	$| = 1;
	unless ( $ENV{HARNESS_ACTIVE} ) {
		require FindBin;
		$FindBin::Bin = $FindBin::Bin; # Avoid a warning
		chdir catdir( $FindBin::Bin, updir() );
		lib->import( 'blib', 'lib' );
	}
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

exit(0);






sub tests {
	is( PPI::Element->significant, 1, 'PPI::Element->significant returns true' );
	is( PPI::Token::Comment->significant, '', 'PPI::Token::Comment->significant return false' );
	is( PPI::Token::Whitespace->significant, '', 'PPI::Token::Whitespace->significant return false' );
	is( PPI::Token::End->significant, '', 'PPI::Token::End->significant returns false' );
}
