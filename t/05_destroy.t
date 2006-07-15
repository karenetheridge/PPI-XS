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

use Test::More tests => 10;

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
	# Start with DESTROY for an element that never has a parent
	{
		my $Token = PPI::Token::Whitespace->new( ' ' );
		my $k1 = scalar keys %PPI::Element::_PARENT;
		$Token->DESTROY;
		my $k2 = scalar keys %PPI::Element::_PARENT;
		is( $k1, $k2, '_PARENT key count remains unchanged after naked Element DESTROY' );
	}

	# Next, a single element within a parent
	{
		my $k1 = scalar keys %PPI::Element::_PARENT;
		my $k2;
		my $k3;
		{
			my $Token     = PPI::Token::Number->new( '1' );
			my $Statement = PPI::Statement->new;
			$Statement->add_element( $Token );
			$k2 = scalar keys %PPI::Element::_PARENT;
			is( $k2, $k1 + 1, 'PARENT keys increases after adding element' );
			$Statement->DESTROY;
		}
		sleep 1;
		$k3 = scalar keys %PPI::Element::_PARENT;
		is( $k3, $k1, 'PARENT keys returns to original on DESTROY' );
	}
}
