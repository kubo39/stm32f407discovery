module stm32f407discovery.interrupt;

version(ARM_Thumb):
extern(C):
@nogc:
nothrow:

pragma(LDC_no_moduleinfo);
pragma(LDC_no_typeinfo);

/**
 *  NVIC
 */

__gshared Nvic* NVIC = cast(Nvic*) 0xE000E100;

struct Nvic
{
    uint[8] iser;
    uint[24] __reserved0;
    uint[8] icer;
    uint[24] __reserved1;
    uint[8] ispr;
    uint[24] __reserved2;
    uint[8] icpr;
    uint[24] __reserved3;
    uint[8] iabr;
    uint[56] __reserved4;
    uint[240] ip;
    uint[644] __reserved5;
    uint stir;
}

// Enable interrupt.
void enable(Nvic* _, uint nr)
{
    auto iser = &NVIC.iser[nr / 32];
    *iser = 1 << nr;
}
