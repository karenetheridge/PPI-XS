use strict;
use inc::Module::Install;

name           'PPI-XS';
all_from       'lib/PPI/XS.pm';
requires       'PPI'        => '0.845';
build_requires 'File::Spec' => '0.82';
build_requires 'Test::More' => '0.47';

WriteAll;
