#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "ppport.h"

MODULE = PPI::XS	PACKAGE = PPI::XS

PROTOTYPES: DISABLE





SV *
_PPI_Element__significant ( ... )
PPCODE:
{
    XSRETURN_YES;
}

SV *
_PPI_Token_Comment__significant ( ... )
PPCODE:
{
    XSRETURN_NO;
}

SV *
_PPI_Token_Whitespace__significant ( ... )
PPCODE:
{
    XSRETURN_NO;
}

SV *
_PPI_Token_End__significant ( ... )
PPCODE:
{
    XSRETURN_NO;
}






SV *
_PPI_Node__scope ( ... )
PPCODE:
{
    XSRETURN_NO;
}

SV *
_PPI_Document__scope ( ... )
PPCODE:
{
    XSRETURN_YES;
}

SV *
_PPI_Document_Fragment__scope ( ... )
PPCODE:
{
    XSRETURN_NO;
}

SV *
_PPI_Structure__scope ( ... )
PPCODE:
{
    XSRETURN_NO;
}

SV *
_PPI_Structure_Block__scope ( ... )
PPCODE:
{
    XSRETURN_YES;
}





void
_PPI_Element__DESTROY ( ... )
PPCODE:
{
    if (SvROK(ST(0))) {
        HV* parent;
        parent = get_hv("PPI::Element::_PARENT", 0);
        if (parent)
            hv_delete_ent(parent, newSVuv(PTR2UV(SvRV(ST(0)))), G_DISCARD, 0);
    }
    return;
}

SV *
_PPI_Token__content ( ... )
PPCODE:
{
    if (SvOK(ST(0)) && SvTYPE(ST(0)) == SVt_PVHV) {
        SV** content;
        content = hv_fetch((HV*)ST(0), "content", 7, TRUE);
        if (content) {
            ST(0) = *content;
            XSRETURN(1);
        }
    }
    /* if we got here, the lookup failed; return nothing. */
    XSRETURN_UNDEF;
}

SV *
_PPI_Token__set_content ( ... )
PPCODE:
{
    if (SvOK(ST(0)) && SvTYPE(ST(0)) == SVt_PVHV && SvOK(ST(1))) { 
        if (hv_store((HV*)ST(0), "content", 7, ST(1), 0)) {
            ST(0) = ST(1);
            XSRETURN(1);
        }
    }
    /* if we got here, the lookup failed; return nothing. */
    XSRETURN_UNDEF;
}

SV *
_PPI_Token__add_content ( ... )
PPCODE:
{
    if (SvOK(ST(0)) && SvTYPE(ST(0)) == SVt_PVHV && SvOK(ST(1))) {
        SV** content;
        content = hv_fetch((HV*)ST(0), "content", 7, TRUE);
        if (content) {
            ST(0) = *content;
            sv_catsv(ST(0), ST(1));
            XSRETURN(1);
        }
    }
    /* if we got here, the lookup failed; return nothing. */
    XSRETURN_UNDEF;
}
