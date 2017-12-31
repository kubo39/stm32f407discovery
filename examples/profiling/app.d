import cortexm;
import ldc.llvmasm;

@nogc:
nothrow:

extern (C) void main()
{
    pragma(LDC_never_inline);

    DWT.enableCycleCounter();

    auto start = DWT.cyccnt;
    __asm("nop", "");
    auto end = DWT.cyccnt;

    // Use volatile to prevent LLVM from optimization.
    volatileStore(cast(uint*) 0x20000000, end - start);

    __asm("bkpt", "");  // gdb: >>> x 0x20000000
}
