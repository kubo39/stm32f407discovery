module stm32f407discovery.usart;

import cortexm;
import stm32f407discovery.rcc;

version (ARM_Thumb) :
@nogc:
nothrow:

version (LDC)
{
    pragma(LDC_no_moduleinfo);
    pragma(LDC_no_typeinfo);
}

__gshared Usart* USART2 = cast(Usart*) 0x40004400; // Start address of the Usart2 register
__gshared Usart* USART3 = cast(Usart*) 0x40004800; // Start address of the Usart3 register
__gshared Usart* USART1 = cast(Usart*) 0x40011000; // Start address of the Usart1 register
__gshared Usart* USART6 = cast(Usart*) 0x40011400; // Start address of the Usart6 register

/**
Usart
 */
struct Usart
{
    uint sr; // Status register.
    uint dr; // Data register.
    uint brr; // Baud rate register.
    uint cr1; // Control register 1.
    uint cr2; // Control register 2.
    uint cr3; // Control regiter 3.
    uint gtpr; // Guard time and prescaler register.
}

void powerOnUsart2()
{
    auto apb1enr = &RCC.apb1enr;
    volatileStore(apb1enr, volatileLoad(apb1enr) | RCC_APB1ENR_USART2EN);
}

void powerOnUsart3()
{
    auto apb1enr = &RCC.apb1enr;
    volatileStore(apb1enr, volatileLoad(apb1enr) | RCC_APB1ENR_USART3EN);
}

void powerOnUsart1()
{
    auto apb2enr = &RCC.apb2enr;
    volatileStore(apb2enr, volatileLoad(apb2enr) | RCC_APB2ENR_USART1EN);
}

void powerOnUsart6()
{
    auto apb2enr = &RCC.apb2enr;
    volatileStore(apb2enr, volatileLoad(apb2enr) | RCC_APB2ENR_USART6EN);
}

enum CR1
{
    SBK = 0,
    RWU = 1,
    RE = 2,
    TE = 3,
    IDLEIE = 4,
    RXNEIE = 5,
    TCIE = 6,
    TXEIE = 7,
    PEIE = 8,
    PS = 9,
    PCE = 10,
    WAKE = 11,
    M = 12,
    UE = 13,
    // reserved
    OVER8 = 15,
}

void enable(Usart* usart, CR1 bit)
{
    auto cr1 = &usart.cr1;
    volatileStore(cr1, volatileLoad(cr1) | 1 << bit);
}

void disable(Usart* usart, CR1 bit)
{
    auto cr1 = &usart.cr1;
    volatileStore(cr1, volatileLoad(cr1) & ~(1 << bit));
}

void setStopBits(Usart* usart, ubyte stop)
{
    auto cr2 = &usart.cr2;
    volatileStore(cr2, volatileLoad(cr2) | stop << 12);
}

enum CR3
{
    EIE = 0,
    IREN = 1,
    IRLP = 2,
    HDSEL = 3,
    NACK = 4,
    SCEN = 5,
    DMAR = 6,
    DMAT = 7,
    RTSE = 8,
    CTSE = 9,
    CTSIE = 10,
    ONEBIT = 11,
}

void enable(Usart* usart, CR3 bit)
{
    auto cr3 = &usart.cr3;
    volatileStore(cr3, volatileLoad(cr3) | 1 << bit);
}

void disable(Usart* usart, CR3 bit)
{
    auto cr3 = &usart.cr3;
    volatileStore(cr3, volatileLoad(cr3) & ~(1 << bit));
}

void setBaudRate(Usart* usart, ubyte fraction, ushort mantissa)
{
    auto brr = &usart.brr;
    volatileStore(brr, volatileLoad(brr) | fraction);
    volatileStore(brr, volatileLoad(brr) | (mantissa << 4));
}
