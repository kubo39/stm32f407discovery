import stm32f407discovery;

// For writting messages to host's console.
import semihosting;

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
