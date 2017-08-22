import cortexm;

import ldc.llvmasm;

extern (C):
@nogc:
nothrow:

enum SYS : uint
{
    OPEN = 1,
    WRITE = 5,
}

enum MODE : uint
{
    W_TRUNC = 4,
}

uint syscall(uint nr, const uint* arg)
{
    return __asm!int("bkpt 0xAB", "={r0}, {r0}, {r1}", nr, arg);
}

int open(in string name, uint mode)
{
    uint[3] arg = [cast(uint) name.ptr, mode, name.length - 1];
    return cast(int) syscall(SYS.OPEN, cast(const uint*) arg.ptr);
}

int write(uint fd, in ubyte* ptr, uint len)
{
    uint[3] arg = [fd, cast(uint) ptr, len];
    return cast(int) syscall(SYS.WRITE, cast(const uint*) arg.ptr);
}

void writeAll(in ubyte[] buffer)
{
    auto fd = open(":tt\0", MODE.W_TRUNC);

    auto ptr = buffer.ptr;
    auto len = buffer.length;

    while (len > 0)
    {
        auto n = write(fd, ptr, len);
        if (n == 0)
            break;
        len -= n;
        ptr += n;
    }
}

void main()
{
    pragma(LDC_never_inline);

    ubyte[6] words = ['H', 'e', 'l', 'l', 'o', '\n'];
    writeAll(words);
    while (true)
        wfi();
}
