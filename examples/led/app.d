import stm32f407discovery;

import stm32f407discovery.adc;
import stm32f407discovery.led;
import stm32f407discovery.timer;

@nogc:
nothrow:

extern (C) void main()
{
    pragma(LDC_never_inline);

    auto tim2 = powerOnTIM!"TIM2"();
    initLED();

    // Initialize ADC1 with a PC2 pin.
    initADC1!"GPIOC"(2);

    tim2.pause();
    tim2.setPrescaler(7999);

    while (true)
    {
        auto ticks = 1000;
        foreach (led; LEDS)
        {
            led.on();
            delay(ticks, tim2);
            led.off();
            delay(ticks, tim2);
        }
    }
}

void delay(uint ticks, Tim* tim)
{
    pragma(LDC_never_inline);

    tim.setAutoreload(ticks);
    tim.resume();

    while (!tim.isUpdated())
    {
    }
    tim.clearUpdateFlag();
}
