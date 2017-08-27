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
