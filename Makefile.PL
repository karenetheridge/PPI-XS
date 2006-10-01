use inc::Module::Install;

name          ( 'PPI-XS'                              );
abstract      ( 'XS acceleration for the core PPI package' );
author        ( 'Richard Soderberg <rsod at cpan.org' );
version_from  ( 'lib/PPI/XS.pm'                       );
license       ( 'perl'                                );

requires      ( 'perl'                     => '5.005' );
requires      ( 'PPI'                      => '0.845' );

build_requires( 'File::Spec'               => '0.82'  );
build_requires( 'Test::More'               => '0.47'  );

&WriteAll;
