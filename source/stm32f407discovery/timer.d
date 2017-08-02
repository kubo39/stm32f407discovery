module stm32f407discovery.timer;

import stm32f407discovery.rcc;

version(ARM_Thumb):
extern(C):
@nogc:
nothrow:

pragma(LDC_no_moduleinfo);
pragma(LDC_no_typeinfo);


/**
 *  Timer
 */

__gshared Tim* TIM2  = cast(Tim*) 0x40000000;  // Start address of the TIM2 register
__gshared Tim* TIM3  = cast(Tim*) 0x40000400;  // Start address of the TIM3 register
__gshared Tim* TIM4  = cast(Tim*) 0x40000800;  // Start address of the TIM4 register
__gshared Tim* TIM5  = cast(Tim*) 0x40000C00;  // Start address of the TIM5 register
__gshared Tim* TIM6  = cast(Tim*) 0x40001000;  // Start address of the TIM6 register
__gshared Tim* TIM7  = cast(Tim*) 0x40001400;  // Start address of the TIM7 register
__gshared Tim* TIM12 = cast(Tim*) 0x40001800;  // Start address of the TIM12 register
__gshared Tim* TIM13 = cast(Tim*) 0x40001C00;  // Start address of the TIM13 register
__gshared Tim* TIM14 = cast(Tim*) 0x40002000;  // Start address of the TIM14 register
__gshared Tim* TIM1  = cast(Tim*) 0x40010000;  // Start address of the TIM1 register
__gshared Tim* TIM8  = cast(Tim*) 0x40010400;  // Start address of the TIM8 register
__gshared Tim* TIM9  = cast(Tim*) 0x40014000;  // Start address of the TIM9 register
__gshared Tim* TIM10 = cast(Tim*) 0x40014400;  // Start address of the TIM10 register
__gshared Tim* TIM11 = cast(Tim*) 0x40014800;  // Start address of the TIM11 register


struct Tim
{
    ushort cr1;
    ushort __reserved0;
    ushort cr2;
    ushort __reserved1;
    ushort smcr;
    ushort __reserved2;
    ushort dier;
    ushort __reserved3;
    ushort sr;
    ushort __reserved4;
    ushort egr;
    ushort __reserved5;
    ushort ccmr1;
    ushort __reserved6;
    ushort ccmr2;
    ushort __reserved7;
    ushort ccer;
    ushort __reserved8;
    uint cnt;
    ushort psc;
    ushort __reserved9;
    uint arr;
    ushort  rcr;
    ushort __reserved10;
    uint ccr1;
    uint ccr2;
    uint ccr3;
    uint ccr4;
    ushort bdtr;
    ushort __reserved11;
    ushort dcr;
    ushort __reserved12;
    ushort dmar;
    ushort __reserved13;
    ushort or;
    ushort __reserved14;
}

// Initialize TIM2.
void initTim2()
{
    auto apb1enr = &RCC.apb1enr;
    *apb1enr |= 1;
}

// Initialize TIM3.
void initTim3()
{
    auto apb1enr = &RCC.apb1enr;
    *apb1enr |= 1 << 1;
}

// Initialize TIM4.
void initTim4()
{
    auto apb1enr = &RCC.apb1enr;
    *apb1enr |= 1 << 2;
}

// Resume the timer count.
void resume(Tim* tim)
{
    auto cr1 = &tim.cr1;
    *cr1 |= 1;
}

// Pause the timer count.
void pause(Tim* tim)
{
    auto cr1 = &tim.cr1;
    *cr1 &= ~1;
}

// Configure the prescaler to have the timer operate.
void setPrescaler(Tim* tim, ushort prescaler)
{
    auto psc = &tim.psc;
    *psc = prescaler;
}

// set the timer to go off `autoreload` ticks.
void setAutoreload(Tim* tim, uint autoreload)
{
    auto arr = &tim.arr;
    *arr = autoreload;
}

// Check if update event has occurred.
bool isUpdated(Tim* tim)
{
    uint uifBit = 1;
    auto sr = &tim.sr;
    return (*sr & uifBit) == 1 ? true : false;
}

// Clear update flag.
void clearUpdateFlag(Tim* tim)
{
    auto sr = &tim.sr;
    *sr &= ~1;
}