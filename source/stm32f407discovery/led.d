module stm32f407discovery.led;

import cortexm;
import stm32f407discovery.gpio;

version (ARM_Thumb) :
@nogc:
nothrow:

version (LDC)
{
    pragma(LDC_no_moduleinfo);
    pragma(LDC_no_typeinfo);
}

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

struct Led
{
    Color color;

    this(Color color) nothrow @nogc
    {
        this.color = color;
    }

    void off() nothrow @nogc
    {
        volatileStore(&GPIOD.odr, volatileLoad(&GPIOD.odr) & ~(1 << this.color));
    }

    void on() nothrow @nogc
    {
        volatileStore(&GPIOD.odr, volatileLoad(&GPIOD.odr) | (1 << this.color));
    }

    void toggle() nothrow @nogc
    {
        auto odr = &GPIOD.odr;
        volatileStore(odr, volatileLoad(odr) ^ (1 << this.color));
    }

    void setMode(Mode mode) nothrow @nogc
    {
        GPIOD.setMode(this.color, mode);
    }
}

__gshared Led[4] LEDS = [Led(Color.GREEN), Led(Color.ORANGE), Led(Color.RED), Led(Color.BLUE)];

void initLED()
{
    powerOnGpiod();
    GPIOD.setMode(Color.GREEN, Mode.Out);
    GPIOD.setMode(Color.ORANGE, Mode.Out);
    GPIOD.setMode(Color.RED, Mode.Out);
    GPIOD.setMode(Color.BLUE, Mode.Out);
}
