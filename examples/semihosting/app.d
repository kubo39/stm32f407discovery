import stm32f407discovery;

// For writting messages to host's console.
import semihosting;

extern (C):
@nogc:
nothrow:

void main()
{
    pragma(LDC_never_inline);

    writeln("Hello");
    while (true)
        wfi();
}
