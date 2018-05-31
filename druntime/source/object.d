module object;

alias size_t    = typeof(int.sizeof);
alias ptrdiff_t = typeof(cast(void*)0 - cast(void*)0);
alias string =immutable(char)[];

class Object
{
    bool opEquals(Object o)
    {
        return this is o;
    }
}

class TypeInfo
{
    size_t getHash(scope const void* p) nothrow const
    {
        return cast(size_t)p;
    }

    override bool opEquals(Object o)
    {
        return this is o;
    }

    bool equals(Object p, Object q)
    {
        return p is q;
    }
}

bool _xopEquals(in void*, in void*)
{
    throw new Error("TypeInfo.equals is not implemented");
}

bool __equals(string s1, string s2)
{
    import cortexm;
    return cast(bool) memcmp(cast(const(ubyte)*) s1, cast(const(ubyte)*) s2, s1.length);
}

class TypeInfo_Class : TypeInfo
{
}

alias ClassInfo = TypeInfo_Class;

class TypeInfo_Const : TypeInfo
{ }

class TypeInfo_Struct : TypeInfo
{
    override bool opEquals(Object o)
    {
        return this is o;
    }
}

class Throwable
{ }

class Error : Throwable
{
    this(string x)
    { }
}
