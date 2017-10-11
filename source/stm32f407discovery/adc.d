module stm32f407discovery.adc;

import cortexm;
import stm32f407discovery.gpio;
import stm32f407discovery.rcc;

version (ARM_Thumb):
@nogc:
nothrow:

version (LDC)
{
    pragma(LDC_no_moduleinfo);
    pragma(LDC_no_typeinfo);
}

__gshared Adc* ADC1 = cast(Adc*) 0x40012000;  // Start address of the ADC1 register.
__gshared Adc* ADC2 = cast(Adc*) 0x40012100;  // Start address of the ADC2 register.
__gshared Adc* ADC3 = cast(Adc*) 0x40012200;  // Start address of the ADC3 register.

// ADC Common registers.
__gshared AdcCommon* ADC_COMMON = cast (AdcCommon*) 0x40012300;


/**
Analog-to-Digital Converter.
 */
struct Adc
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
    uint dr;

    void on() nothrow @nogc
    {
        this.cr2 |= 1;
    }

    void off() nothrow @nogc
    {
        this.cr2 &= ~1;
    }
}

static assert(Adc.sizeof == 0x4c + 0x4);


/**
ADC Common registers.
*/
struct AdcCommon
{
    uint csr;
    uint ccr;
    uint cdr;
}

static assert(AdcCommon.sizeof == 0x8 + 0x4);


/**
Enable ADC1.
 */
void enableADC1()
{
    auto apb2enr = &RCC.apb2enr;
    volatileStore(apb2enr, volatileLoad(apb2enr) | RCC_APB2ENR_ADC1EN);
}

/**
Enable ADC2.
 */
void enableADC2()
{
    auto apb2enr = &RCC.apb2enr;
    volatileStore(apb2enr, volatileLoad(apb2enr) | RCC_APB2ENR_ADC2EN);
}


/**
Initialize ADC1 with Pin.
 */
void initADC1(Gpio* gpio, ubyte pin)
{
    // Enable ADC1.
    enableADC1();

    // Set pin as analog input.
    gpio.setMode(pin, Mode.In);

    // A/D Converter on.
    ADC1.on();
}
