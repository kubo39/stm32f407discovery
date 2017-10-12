module stm32f407discovery.gpio;

import cortexm;
import stm32f407discovery.rcc;

version (ARM_Thumb)  :
@nogc:
nothrow:

version (LDC)
{
    pragma(LDC_no_moduleinfo);
    pragma(LDC_no_typeinfo);
}


__gshared Gpio* GPIOA = cast(Gpio*) 0x40020000; // Start address of the GPIOA register
__gshared Gpio* GPIOB = cast(Gpio*) 0x40020400; // Start address of the GPIOB register
__gshared Gpio* GPIOC = cast(Gpio*) 0x40020800; // Start address of the GPIOC register
__gshared Gpio* GPIOD = cast(Gpio*) 0x40020C00; // Start address of the GPIOD register
__gshared Gpio* GPIOE = cast(Gpio*) 0x40021000; // Start address of the GPIOE register
__gshared Gpio* GPIOF = cast(Gpio*) 0x40021400; // Start address of the GPIOF register
__gshared Gpio* GPIOG = cast(Gpio*) 0x40021800; // Start address of the GPIOG register
__gshared Gpio* GPIOH = cast(Gpio*) 0x40021C00; // Start address of the GPIOH register
__gshared Gpio* GPIOI = cast(Gpio*) 0x40022000; // Start address of the GPIOI register
__gshared Gpio* GPIOJ = cast(Gpio*) 0x40022400; // Start address of the GPIOJ register
__gshared Gpio* GPIOK = cast(Gpio*) 0x40022800; // Start address of the GPIOK register




enum Mode
{
    In = 0b00,
    Out = 0b01,
    AltFunc = 0b10,
    Analog = 0b11,
}


/**
GPIO
 */
struct Gpio
{
    uint moder;
    uint otyper;
    uint ospeedr;
    uint pupdr;
    uint idr;
    uint odr;
    uint bsrr;
    uint lckr;
    uint afrl;
    uint afrh;
}

static assert(Gpio.sizeof == 0x24 + 0x4);


Gpio* powerOnGPIO(string s)()
{
    static if (s == "GPIOA" || s == "GPIOB"
               || s == "GPIOC" || s == "GPIOD" || s == "GPIOE")
        mixin("volatileStore(&RCC.ahb1enr, volatileLoad(&RCC.ahb1enr) | RCC_AHB1ENR_"
              ~ s ~ "EN);return " ~ s ~ ";");
    else static assert (false);
}


void setMode(Gpio* gpio, ubyte pin, Mode mode)
{
    volatileStore(&gpio.moder, volatileLoad(&gpio.moder) | (volatileLoad(&gpio.moder) & ~(0b11 << pin * 2)) | (mode << pin * 2));
}


void setAltFunc(Gpio* gpio, ubyte pin)
{
    volatileStore(&gpio.afrl, volatileLoad(&gpio.afrl) | (0b111 << pin));
}
