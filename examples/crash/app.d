import cortexm;

import stm32f407discovery.led;

extern(C):
@nogc:
nothrow:

void main()
{
    initLED();

    auto boundary = *cast(uint*) 0x0000_0000;
    auto crash = *cast(uint*) boundary;

    while (true) {}
}

void HardFaultExceptionHandler()
{
    // RED
    LEDS[2].on();
    bkpt();
    while (true) {
        wfi();
    }
}
