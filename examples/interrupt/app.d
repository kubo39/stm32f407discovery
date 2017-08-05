import stm32f407discovery;

import stm32f407discovery.interrupt;
import stm32f407discovery.led;
import stm32f407discovery.timer;

extern(C):
@nogc:
nothrow:

void main()
{
    pragma(LDC_never_inline);

    powerOnTim2();
    initLED();

    TIM2.pause();
    TIM2.setPrescaler(64);
    TIM2.setAutoreload(328124);
    TIM2.resume();

    // Enable TIM2 update IRQ.
    auto iser = &Nvic.iser[0];
    *iser = 1 << 28;
    auto dier = &TIM2.dier;
    *dier = 1;

    while (true) {}
}

void TIM2_IRQInterruptHandler()
{
    if (TIM2.isUpdated()) {
        // RED
        LEDS[2].on();
    }
    TIM2.clearUpdateFlag();
    while (true) {}
}
