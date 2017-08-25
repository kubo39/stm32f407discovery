module stm32f407discovery.serial;

import stm32f407discovery.gpio;
import stm32f407discovery.usart;

version (ARM_Thumb)  :
extern (C):
@nogc:
nothrow:

version (LDC)
{
    pragma(LDC_no_moduleinfo);
    pragma(LDC_no_typeinfo);
}

/**
 *  Serial
 */

immutable uint APB1 = 16000000;

void initSerial(ushort baudRate)
{
    powerOnGpioa();
    powerOnUsart2();

    // Configure PA2 as TX and PA3 as RX
    GPIOA.setAltFunc(2);
    GPIOA.setAltFunc(3);

    GPIOA.setMode(2, Mode.AltFunc);
    GPIOA.setMode(3, Mode.AltFunc);

    // 1 stop bit.
    USART2.setStopBits(0b00);

    // Disable hardware control.
    USART2.disable(CR3.RTSE);
    USART2.disable(CR3.CTSE);

    // Set baud rate.
    ushort brr = cast(ushort)(APB1 / baudRate);
    ubyte fraction = brr & 0b1111;
    ushort mantissa = brr >> 4;
    USART2.setBaudRate(fraction, mantissa);

    // enable peripheral, transmitter, receiver
    // enable RXNE event
    USART2.enable(CR1.UE);
    USART2.enable(CR1.RE);
    USART2.enable(CR1.TE);
    USART2.disable(CR1.PCE);
    USART2.disable(CR1.OVER8);
    USART2.enable(CR1.RXNEIE);
}
