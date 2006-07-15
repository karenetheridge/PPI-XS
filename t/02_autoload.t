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

use Test::More tests => 4;

# Load PPI
use_ok( 'PPI' );

# Double check PPI itself was loaded
ok( $PPI::VERSION, 'PPI was autoloaded by PPI::XS' );
ok( $PPI::Element::VERSION, 'The PDOM has been loaded' );

# Did PPI::XS get loaded?
ok( $PPI::XS::VERSION, 'PPI::XS was autoloaded ok' );

exit(0);
