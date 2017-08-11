module stm32f407discovery.rcc;

version(ARM_Thumb):
extern(C):
@nogc:
nothrow:

/**
 *  Rcc
 */

__gshared Rcc* RCC = cast(Rcc*) 0x40023800;  // Start address of the RCC register

immutable
{
    // AHB1ENR
    uint RCC_AHB1ENR_GPIOAEN = 1;
    uint RCC_AHB1ENR_GPIOBEN = 1 << 1;
    uint RCC_AHB1ENR_GPIOCEN = 1 << 2;
    uint RCC_AHB1ENR_GPIODEN = 1 << 3;
    uint RCC_AHB1ENR_GPIOEEN = 1 << 4;

    // APB1ENR
    uint RCC_APB1ENR_TIM2EN = 1;
    uint RCC_APB1ENR_TIM3EN = 1 << 1;
    uint RCC_APB1ENR_TIM4EN = 1 << 2;
    uint RCC_APB1ENR_TIM5EN = 1 << 3;
    uint RCC_APB1ENR_TIM6EN = 1 << 4;
    uint RCC_APB1ENR_TIM7EN = 1 << 5;
    uint RCC_APB1ENR_TIM12EN = 1 << 6;
    uint RCC_APB1ENR_TIM13EN = 1 << 7;
    uint RCC_APB1ENR_TIM14EN = 1 << 8;
    uint RCC_APB1ENR_USART2EN = 1 << 17;
    uint RCC_APB1ENR_USART3EN = 1 << 18;
}

struct Rcc
{
    uint cr;
    uint pllcfgr;
    uint cfgr;
    uint cir;
    uint ahb1rstr;
    uint ahb2rstr;
    uint ahb3rstr;
    uint __reserved0;
    uint apb1rstr;
    uint apb2rstr;
    uint[2] __reserved1;
    uint ahb1enr;
    uint ahb2enr;
    uint ahb3enr;
    uint __reserved2;
    uint apb1enr;
    uint apb2enr;
    uint[2] __reserved3;
    uint ahb1lpenr;
    uint ahb2lpenr;
    uint ahb3lpenr;
    uint __reserved4;
    uint apb1lpenr;
    uint apb2lpenr;
    uint __reserved5;
    uint bdcr;
    uint csr;
    uint[2] __reserved6;
    uint sscgr;
    uint plli2scfgr;
    uint pllsaicfgr;
    uint dckcfgr;
    uint ckgatenr;
    uint dckcfgr2;
}
