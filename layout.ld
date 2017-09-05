ENTRY(_reset);

MEMORY
{
  CCRAM (!rwxai) : ORIGIN = 0x10000000, LENGTH = 64K
  FLASH (r!wxai) : ORIGIN = 0x08000000, LENGTH = 1024K
  RAM (!rwxai) : ORIGIN = 0x20000000, LENGTH = 128K
}

PROVIDE(_stack_start = ORIGIN(RAM) + LENGTH(RAM));

SECTIONS
{
  .isr_vector ORIGIN(FLASH) : ALIGN(4)
  {
    /* Vector table */
    _reset = .;
    LONG(_stack_start);
    KEEP(*(.isr_vector._reset));
    KEEP(*(.isr_vector.exceptions));
    KEEP(*(.isr_vector.interrupts));
  } > FLASH

  _stext = .;

  .text _stext : ALIGN(4)
  {
    /* Reset handler */
    KEEP(*(.text.reset_handler));

    /* the code */
    *(.text);
    *(.text*);
  } > FLASH

  /* __gshared immutable variables. */
  .rodata : ALIGN(4)
  {
    *(.rodata);
    *(.rodata*);
    . = ALIGN(4);
  } > FLASH

  /* uninitialized __gshared variables and C linkage. */
  .bss : ALIGN(4)
  {
    _sbss = .;
    *(.bss);
    *(.bss.*);
    . = ALIGN(4);
    _ebss = .;
  } > RAM

  /* __gshared variables. */
  .data : ALIGN(4)
  {
    _sidata = LOADADDR(.data);
    _sdata = .;
    *(.data);
    *(.data.*);
    . = ALIGN(4);
    _edata = .;
  } > FLASH

  /DISCARD/ :
  {
    *(.ARM.exidx*)
    *(.ARM.extab*)
    *(.note.gnu.build-id*)
  }
}

/*  EXCEPTIONS. */
PROVIDE(NMIExceptionHandler = defaultExceptionHandler);
PROVIDE(HardFaultExceptionHandler = defaultExceptionHandler);
PROVIDE(MemmanageFaultExceptionHandler = defaultExceptionHandler);
PROVIDE(BusFaultExceptionHandler = defaultExceptionHandler);
PROVIDE(UsageFaultExceptionHandler = defaultExceptionHandler);
PROVIDE(SVCallExceptionHandler = defaultExceptionHandler);
PROVIDE(PendSVExceptionHandler = defaultExceptionHandler);
PROVIDE(SystickExceptionHandler = defaultExceptionHandler);

/* INTERRUPTS */
PROVIDE(WWDG_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(PVD_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(TAMP_STAMP_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(RTC_WKUP_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(FLASH_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(RCC_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(EXTI0_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(EXTI1_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(EXTI2_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(EXTI3_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(EXTI4_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(DMA1_Stream0_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(DMA1_Stream1_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(DMA1_Stream2_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(DMA1_Stream3_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(DMA1_Stream4_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(DMA1_Stream5_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(DMA1_Stream6_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(ADC_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(CAN1_TX_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(CAN1_RX0_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(CAN1_RX1_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(CAN1_SCE_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(EXTI9_5_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(TIM1_BRK_TIM9_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(TIM1_UP_TIM10_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(TIM1_TRG_COM_TIM11_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(TIM1_CC_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(TIM2_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(TIM3_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(TIM4_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(I2C1_EV_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(I2C1_ER_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(I2C2_EV_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(I2C2_ER_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(SPI1_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(SPI2_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(USART1_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(USART2_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(USART3_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(EXTI15_10_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(RTC_Alarm_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(OTG_FS_WKUP_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(TIM8_BRK_TIM12_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(TIM8_UP_TIM13_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(TIM8_TRG_COM_TIM14_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(TIM8_CC_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(DMA1_Stream7_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(FSMC_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(SDIO_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(TIM5_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(SPI3_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(UART4_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(UART5_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(TIM6_DAC_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(TIM7_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(DMA2_Stream0_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(DMA2_Stream1_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(DMA2_Stream2_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(DMA2_Stream3_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(DMA2_Stream4_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(ETH_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(ETH_WKUP_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(CAN2_TX_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(CAN2_RX0_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(CAN2_RX1_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(CAN2_SCE_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(OTG_FS_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(DMA2_Stream5_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(DMA2_Stream6_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(DMA2_Stream7_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(USART6_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(I2C3_EV_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(I2C3_ER_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(OTG_HS_EP1_OUT_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(OTG_HS_EP1_IN_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(OTG_HS_WKUP_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(OTG_HS_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(DCMI_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(CRYP_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(HASH_RNG_IRQInterruptHandler = defaultInterruptHandler);
PROVIDE(FPU_IRQInterruptHandler = defaultInterruptHandler);
