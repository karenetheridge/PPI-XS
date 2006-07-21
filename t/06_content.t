#!/usr/bin/perl -w

# content() testing for PPI::XS

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

exit(0);






sub tests {
   my $Token = PPI::Token::Whitespace->new( ' ' );
   is( $Token->content, ' ', 'content' );
   is( $Token->set_content(' '), ' ', 'set_content' );
   is( $Token->content, ' ', 'content' );
   is( $Token->add_content('foo'), ' foo', 'set_content' );
   is( $Token->content, ' foo', 'content' );
}
