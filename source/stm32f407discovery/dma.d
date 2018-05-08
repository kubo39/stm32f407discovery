module stm32f407discovery.dma;

import cortexm;
import core.bitop;
import stm32f407discovery.rcc;

version (ARM_Thumb):
@nogc:
nothrow:

version (LDC)
{
    pragma(LDC_no_moduleinfo);
    pragma(LDC_no_typeinfo);
}

__gshared Dma* DMA1 = cast(Dma*) 0x40026000;  // Start Address of the DMA1 register.
__gshared Dma* DMA2 = cast(Dma*) 0x40026400;  // Start Address of the DMA2 register.


/**
Direct Memory Access.
 */
struct Dma
{
    uint lisr;
    uint hisr;
    uint lifcr;
    uint hifcr;
    uint s0cr;
    uint s0ndtr;
    uint s0par;
    uint s0m0ar;
    uint s0m1ar;
    uint s0fcr;
    uint s1cr;
    uint s1ndtr;
    uint s1par;
    uint s1m0ar;
    uint s1m1ar;
    uint s1fcr;
    uint s2cr;
    uint s2ndtr;
    uint s2par;
    uint s2m0ar;
    uint s2m1ar;
    uint s2fcr;
    uint s3cr;
    uint s3ndtr;
    uint s3par;
    uint s3m0ar;
    uint s3m1ar;
    uint s3fcr;
    uint s4cr;
    uint s4ndtr;
    uint s4par;
    uint s4m0ar;
    uint s4m1ar;
    uint s4fcr;
    uint s5cr;
    uint s5ndtr;
    uint s5par;
    uint s5m0ar;
    uint s5m1ar;
    uint s5fcr;
    uint s6cr;
    uint s6ndtr;
    uint s6par;
    uint s6m0ar;
    uint s6m1ar;
    uint s6fcr;
    uint s7cr;
    uint s7ndtr;
    uint s7par;
    uint s7m0ar;
    uint s7m1ar;
    uint s7fcr;
}

static assert(Dma.sizeof == 0xCC + 0x4);


/**
Enable DMA1.
*/
void enableDMA1()
{
    auto ahb1enr = &RCC.ahb1enr;
    volatileStore(ahb1enr, volatileLoad(ahb1enr) | RCC_AHB1ENR_DMA1EN);
}

/**
Enable DMA2.
*/
void enableDMA2()
{
    auto ahb1enr = &RCC.ahb1enr;
    volatileStore(ahb1enr, volatileLoad(ahb1enr) | RCC_AHB1ENR_DMA2EN);
}
