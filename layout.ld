ENTRY(_reset);

MEMORY
{
  CCRAM : ORIGIN = 0x10000000, LENGTH = 64K
  FLASH : ORIGIN = 0x08000000, LENGTH = 1024K
  RAM : ORIGIN = 0x20000000, LENGTH = 128K
}

SECTIONS
{
  .text :
  {
    /* Vector table */
    LONG(ORIGIN(RAM) + LENGTH(RAM))
    LONG(_reset + 1);
    KEEP(*(.rodata._EXCEPTIONS));
    /* Reset handler */
    _reset = .;
    KEEP(*(.text._reset));

    /* the code */
    *(.text*)
  }>FLASH

  /DISCARD/ :
  {
    *(.ARM.exidx*)
    *(.note.gnu.build-id*)
  }
}

PROVIDE(NMIExceptionHandler = defaultExceptionHandler);
PROVIDE(HardFaultExceptionHandler = defaultExceptionHandler);
PROVIDE(MemmanageFaultExceptionHandler = defaultExceptionHandler);
PROVIDE(BusFaultExceptionHandler = defaultExceptionHandler);
PROVIDE(UsageFaultExceptionHandler = defaultExceptionHandler);
PROVIDE(SVCallExceptionHandler = defaultExceptionHandler);
PROVIDE(PendSVExceptionHandler = defaultExceptionHandler);
PROVIDE(SystickExceptionHandler = defaultExceptionHandler);
