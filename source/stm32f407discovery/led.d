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

enum Color : ubyte
{
    GREEN = 12,
    ORANGE = 13,
    RED = 14,
    BLUE = 15,
}


struct LED
{
    private:

    Color color;

    this(Color color) nothrow @nogc
    {
        this.color = color;
    }

    public:

    void off() nothrow @nogc
    {
        auto odr = &GPIOD.odr;
        *odr &= ~(0 | (1 << this.color));
    }

    void on() nothrow @nogc
    {
        auto odr = &GPIOD.odr;
        *odr |= 1 << this.color;
    }
}


__gshared LED[4] LEDS = [
    LED(Color.GREEN),
    LED(Color.ORANGE),
    LED(Color.RED),
    LED(Color.BLUE),
    ];


void initLED()
{
    powerOnGpiod();
    GPIOD.setMode(Color.GREEN, Mode.Out);
    GPIOD.setMode(Color.ORANGE, Mode.Out);
    GPIOD.setMode(Color.RED, Mode.Out);
    GPIOD.setMode(Color.BLUE, Mode.Out);
}
