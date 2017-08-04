ENTRY(_reset);

MEMORY
{
  CCRAM : ORIGIN = 0x10000000, LENGTH = 64K
  FLASH : ORIGIN = 0x08000000, LENGTH = 1024K
  RAM : ORIGIN = 0x20000000, LENGTH = 128K
}

PROVIDE(_stack_start = ORIGIN(RAM) + LENGTH(RAM));

SECTIONS
{
  .text ORIGIN(FLASH) : ALIGN(4)
  {
    /* Vector table */
    LONG(_stack_start);
    _reset = .;
    KEEP(*(.text._reset));
    LONG(reset_handler + 1);
    KEEP(*(.rodata.exceptions));
    /* Reset handler */
    reset_handler = .;
    KEEP(*(.text.reset_handler));

    /* the code */
    *(.text*)
  } > FLASH

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
