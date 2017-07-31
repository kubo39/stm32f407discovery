import stm32f407discovery;

import stm32f407discovery.led;

extern(C):
@nogc:
nothrow:

void main()
{
    pragma(LDC_never_inline);

    initLED();

    auto ticks = 100000;

    while (true) {
        foreach (led; LEDS) {
            led.on();
            delay(ticks);
            led.off();
            delay(ticks);
        }
    }
}

void delay(uint n)
{
    pragma(LDC_never_inline);

    foreach (_; 0 .. n)
    {
        nop();
    }
}
