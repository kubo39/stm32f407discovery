module stm32f407discovery.led;

import stm32f407discovery.gpio;

version(ARM_Thumb):
extern(C):
@nogc:
nothrow:

pragma(LDC_no_moduleinfo);
pragma(LDC_no_typeinfo);

/**
 *  LED
 */


struct LED
{
    ubyte i;

    void off() nothrow @nogc
    {
        auto odr = &GPIOD.odr;
        *odr &= ~(0 | (1 << i));
    }

    void on() nothrow @nogc
    {
        auto odr = &GPIOD.odr;
        *odr |= 1 << i;
    }
}


__gshared LED[4] LEDS = [
    LED(12),
    LED(13),
    LED(14),
    LED(15),
    ];


void initLED()
{
    powerOnGpiod();
    GPIOD.setMode(15, Mode.Out);
    GPIOD.setMode(14, Mode.Out);
    GPIOD.setMode(13, Mode.Out);
    GPIOD.setMode(12, Mode.Out);
}
