import stm32f407discovery;

import stm32f407discovery.led;
import stm32f407discovery.timer;

@nogc:
nothrow:

extern (C) void main()
{
    pragma(LDC_never_inline);

    auto tim2 = powerOn!"TIM2"();
    initLED();

    tim2.pause();

    // APB1_CLOCK = 84 MHz
    // PSC = 83
    // 84 MHz / (83 + 1) = 1 MHz
    tim2.setPrescaler(83);

    while (true)
    {
        auto ticks = 50 * 1000;
        foreach (led; LEDS)
        {
            led.on();
            tim2.delay(ticks);
            led.off();
            tim2.delay(ticks);
        }
    }
}

void delay(Tim* tim, uint ticks)
{
    // 1000 tick = 1 ms
    tim.setAutoreload(ticks);
    tim.resume();

    while (!tim.isUpdated())
    {
    }
    tim.clearUpdateFlag();
}
