import stm32f407discovery;

import stm32f407discovery.led;
import stm32f407discovery.timer;

extern(C):
@nogc:
nothrow:

void main()
{
    pragma(LDC_never_inline);

    initTim2();
    initLED();

    pauseTim2();
    setPrescalerTim2(7999);

    auto ticks = 1000;

    while (true) {
        foreach (led; LEDS) {
            led.on();
            delay(ticks);
            led.off();
            delay(ticks);
        }
    }
}

void delay(uint ticks)
{
    pragma(LDC_never_inline);

    setAutoreloadTim2(ticks);
    resumeTim2();

    while (!isUpdatedTim2) {}
    clearUpdateFlagTim2();
}
