module stm32f407discovery.rcc;

version(ARM_Thumb):
extern(C):
@nogc:
nothrow:

/**
 *  Rcc
 */

__gshared Rcc* RCC = cast(Rcc*) 0x40023800;  // Start address of the RCC register

const uint RCC_AHB1ENR_GPIODEN = 0x00000008;  // GPIODEN bit mask

struct Rcc
{
    uint cr;
    uint pllcfgr;
    uint cfgr;
    uint cir;
    uint ahb1rstr;
    uint ahb2rstr;
    uint ahb3rstr;
    uint __reserved0;
    uint apb1rstr;
    uint apb2rstr;
    uint[2] __reserved1;
    uint ahb1enr;
    uint ahb2enr;
    uint ahb3enr;
    uint __reserved2;
    uint apb1enr;
    uint apb2enr;
    uint[2] __reserved3;
    uint ahb1lpenr;
    uint ahb2lpenr;
    uint ahb3lpenr;
    uint __reserved4;
    uint apb1lpenr;
    uint apb2lpenr;
    uint __reserved5;
    uint bdcr;
    uint csr;
    uint[2] __reserved6;
    uint sscgr;
    uint plli2scfgr;
    uint pllsaicfgr;
    uint dckcfgr;
    uint ckgatenr;
    uint dckcfgr2;
}
