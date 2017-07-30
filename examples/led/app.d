import stm32f407discovery;

import stm32f407discovery.gpio;

extern(C):
@nogc:
nothrow:

void main()
{
    pragma(LDC_never_inline);
    powerOnGpiod();
    ledOn();
}
