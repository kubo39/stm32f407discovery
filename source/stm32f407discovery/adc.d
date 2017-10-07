module stm32f407discovery.adc;

version (ARM_Thumb):
@nogc:
nothrow:

version (LDC)
{
    pragma(LDC_no_moduleinfo);
    pragma(LDC_no_typeinfo);
}

__gshared ADC* ADC1 = cast(ADC*) 0x40012000;  // Start address of the ADC1 register.
__gshared ADC* ADC2 = cast(ADC*) 0x40012100;  // Start address of the ADC2 register.
__gshared ADC* ADC3 = cast(ADC*) 0x40012200;  // Start address of the ADC3 register.


/**
Analog-to-Digital Converter.
 */
struct ADC
{
    uint sr;
    uint cr1;
    uint cr2;
    uint smpr1;
    uint smpr2;
    uint jofr1;
    uint jofr2;
    uint jofr3;
    uint jofr4;
    uint htr;
    uint ltr;
    uint sqr1;
    uint sqr2;
    uint sqr3;
    uint jsqr;
    uint jdr1;
    uint jdr2;
    uint jdr3;
    uint jdr4;
    uint dr1;
    uint csr;
    uint ccr;
    uint cdr;
}
