import cortexm;

@nogc:
nothrow:

extern (C) void main()
{
    pragma(LDC_never_inline);

    // enable cycle counter.
    DWT.enableCycleCounter();

    auto start = DWT.cyccnt;
    nop();
    auto end = DWT.cyccnt;

    auto elapsed = end - start;

    // Use volatile to prevent LLVM from optimization.
    volatileStore(cast(uint*) 0x20000000, elapsed);

    bkpt();  // gdb: >>> x 0x20000000
}
