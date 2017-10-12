module stm32f407discovery;

version (ARM_Thumb) :
@nogc:
nothrow:

version(LDC)
{
    pragma(LDC_no_moduleinfo);
    pragma(LDC_no_typeinfo);
}

public import cortexm;


auto powerOn(string name)()
{
    static if (name == "ADC1" || name == "ADC2")
    {
        import stm32f407discovery.adc;
        return powerOnADC!(name)();
    }
    else static if (name == "GPIOA" || name == "GPIOB" || name == "GPIOC" || name == "GPIOD" || name == "GPIOE")
    {
        import stm32f407discovery.gpio;
        return powerOnGPIO!(name)();
    }
    else static if (name == "TIM2" || name == "TIM3" || name == "TIM4" || name == "TIM5")
    {
        import stm32f407discovery.timer;
        return powerOnTIM!(name)();
    }
    else static if (name == "USART2" || name == "USART3" || name == "USART1" || name == "USART6")
    {
        import stm32f407discovery.usart;
        return powerOnUSART!(name)();
    }
    else static assert (false);
}
