package bench;

use blib;

sub import {
    $PPI::XS_DISABLE = $_[1];

    require PPI::XS;
}

1;
