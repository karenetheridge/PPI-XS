#!/usr/bin/perl -w

# Load testing for PPI::XS

# This test script only tests that the tree compiles

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

use Test::More tests => 4;





# Check their perl version
ok( $] >= 5.005, "Your perl is new enough" );

# Load PPI::XS, which should also load
# PPI and do everything properly
use_ok( 'PPI::XS' );

# Did PPI itself get loaded?
ok( $PPI::VERSION, 'PPI was autoloaded by PPI::XS'     );
ok( $PPI::Element::VERSION, 'The PDOM has been loaded' );

exit(0);
