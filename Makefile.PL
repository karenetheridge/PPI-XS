use inc::Module::Install 0.76;

all_from      'lib/PPI/XS.pm';
requires      'PPI'        => '0.845';
test_requires 'File::Spec' => '0.82';
test_requires 'Test::More' => '0.47';

ppport;

WriteAll;
