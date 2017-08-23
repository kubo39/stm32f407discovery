import stm32f407discovery;

extern (C):
@nogc:
nothrow:

void main()
{
    pragma(LDC_never_inline);

    string words = "Hello\n";
    writeString(words);
    while (true)
        wfi();
}
