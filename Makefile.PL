use strict;
use warnings;

use lib 'inc';
use ExtUtils::MakeMaker::Dist::Zilla::Develop;

WriteMakefile(
    NAME => 'PPI::XS',
    VERSION_FROM => 'lib/PPI/XS.pm',
    INSTALLMAN1DIR => 'none',
    INSTALLMAN3DIR => 'none',
    NORECURS => 1,
);

use Devel::PPPort;
Devel::PPPort::WriteFile();
system("$^X ppport.h --compat-version=5.006 --quiet *.h XS.xs");
