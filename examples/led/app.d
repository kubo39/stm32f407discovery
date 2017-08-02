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

    pause(TIM2);
    setPrescaler(TIM2, 7999);

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

    setAutoreload(TIM2, ticks);
    resume(TIM2);

    while (!isUpdated(TIM2)) {}
    clearUpdateFlag(TIM2);
}
