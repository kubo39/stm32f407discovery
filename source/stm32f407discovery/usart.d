module stm32f407discovery.usart;

import stm32f407discovery.rcc;

version (ARM_Thumb)  : extern (C):
@nogc:
nothrow:

pragma(LDC_no_moduleinfo);
pragma(LDC_no_typeinfo);

/**
 *  Usart
 */

__gshared Usart* USART2 = cast(Usart*) 0x40004400; // Start address of the Usart2 register
__gshared Usart* USART3 = cast(Usart*) 0x40004800; // Start address of the Usart3 register
__gshared Usart* USART1 = cast(Usart*) 0x40011000; // Start address of the Usart1 register
__gshared Usart* USART6 = cast(Usart*) 0x40011400; // Start address of the Usart6 register

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
    *apb1enr |= RCC_APB1ENR_USART2EN;
}

void powerOnUsart3()
{
    auto apb1enr = &RCC.apb1enr;
    *apb1enr |= RCC_APB1ENR_USART3EN;
}

void powerOnUsart1()
{
    auto apb2enr = &RCC.apb2enr;
    *apb2enr |= RCC_APB2ENR_USART1EN;
}

void powerOnUsart6()
{
    auto apb2enr = &RCC.apb2enr;
    *apb2enr |= RCC_APB2ENR_USART6EN;
}
