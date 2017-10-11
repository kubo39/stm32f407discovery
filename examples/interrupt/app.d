import stm32f407discovery;

import stm32f407discovery.led;
import stm32f407discovery.timer;

extern (C):
@nogc:
nothrow:

void main()
{
    pragma(LDC_never_inline);

    auto tim2 = powerOnTIM!"TIM2"();
    initLED();

    tim2.pause();
    tim2.setPrescaler(64);
    tim2.setAutoreload(328124);
    tim2.resume();

    // Enable TIM2 update IRQ.
    NVIC.enable(28);
    tim2.enableUpdateEventInterrupt();

    while (true)
    {
    }
}

void TIM2_IRQInterruptHandler()
{
    if (TIM2.isUpdated())
    {
        // RED
        LEDS[2].on();
    }
    TIM2.clearUpdateFlag();
}
