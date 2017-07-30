module stm32f407discovery.gpio;

import stm32f407discovery.rcc;

version(ARM_Thumb):
extern(C):
@nogc:
nothrow:

pragma(LDC_no_moduleinfo);
pragma(LDC_no_typeinfo);

/**
 *  GPIO
 */

__gshared GPIO* GPIOA = cast(GPIO*) 0x40020000;  // Start address of the GPIOA register
__gshared GPIO* GPIOB = cast(GPIO*) 0x40020400;  // Start address of the GPIOB register
__gshared GPIO* GPIOC = cast(GPIO*) 0x40020800;  // Start address of the GPIOC register
__gshared GPIO* GPIOD = cast(GPIO*) 0x40020C00;  // Start address of the GPIOD register
__gshared GPIO* GPIOE = cast(GPIO*) 0x40021000;  // Start address of the GPIOE register
__gshared GPIO* GPIOF = cast(GPIO*) 0x40021400;  // Start address of the GPIOF register
__gshared GPIO* GPIOG = cast(GPIO*) 0x40021800;  // Start address of the GPIOG register
__gshared GPIO* GPIOH = cast(GPIO*) 0x40021C00;  // Start address of the GPIOH register
__gshared GPIO* GPIOI = cast(GPIO*) 0x40022000;  // Start address of the GPIOI register
__gshared GPIO* GPIOJ = cast(GPIO*) 0x40022400;  // Start address of the GPIOJ register
__gshared GPIO* GPIOK = cast(GPIO*) 0x40022800;  // Start address of the GPIOK register


struct GPIO
{
    uint moder;  /* offser address of the CRH register */
    uint otyper;
    uint ospeedr;
    uint pupdr;
    uint idr;
    uint odr;
    uint bsrrl;
    uint bsrrh;
    uint lckr;
    uint afrl;
    uint afrh;
}

void powerOnGpiod()
{
    auto rcc = cast(Rcc*) RCC;
    // Pointer to the AHB1ENR register
    auto ahb1enr = &rcc.ahb1enr;
    *ahb1enr |= RCC_AHB1ENR_GPIODEN;
}

void ledOn()
{
    auto moder = &GPIOD.moder;
    *moder = 0x40000000;
    auto odr = &GPIOD.odr;
    *odr = 1 << 15;
}
