import stm32f407discovery;

import stm32f407discovery.led;
import stm32f407discovery.timer;

@nogc:
nothrow:

extern (C) void main()
{
    pragma(LDC_never_inline);

    powerOnTim2();
    initLED();

    TIM2.pause();
    TIM2.setPrescaler(7999);

    auto ticks = 1000;

    while (true)
    {
        foreach (led; LEDS)
        {
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

    TIM2.setAutoreload(ticks);
    TIM2.resume();

    while (!TIM2.isUpdated())
    {
    }
    TIM2.clearUpdateFlag();
}
