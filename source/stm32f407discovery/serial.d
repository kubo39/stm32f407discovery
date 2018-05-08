module stm32f407discovery.serial;

import core.bitop;
import stm32f407discovery.gpio;
import stm32f407discovery.usart;

version (ARM_Thumb)  :
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

enum uint APB1 = 16000000;

void initSerial(ushort baudRate)
{
    auto gpioa = powerOnGPIO!"GPIOA"();
    auto usart2 = powerOnUSART!"USART2"();

    // Configure PA2 as TX and PA3 as RX
    gpioa.setAltFunc(2);
    gpioa.setAltFunc(3);

    gpioa.setMode(2, Mode.AltFunc);
    gpioa.setMode(3, Mode.AltFunc);

    // 1 stop bit.
    usart2.setStopBits(0b00);

    // Disable hardware control.
    usart2.disable(CR3.RTSE);
    usart2.disable(CR3.CTSE);

    // Set baud rate.
    ushort brr = cast(ushort)(APB1 / baudRate);
    ubyte fraction = brr & 0b1111;
    ushort mantissa = brr >> 4;
    usart2.setBaudRate(fraction, mantissa);

    // enable peripheral, transmitter, receiver
    // enable RXNE event
    usart2.enable(CR1.UE);
    usart2.enable(CR1.RE);
    usart2.enable(CR1.TE);
    usart2.disable(CR1.PCE);
    usart2.disable(CR1.OVER8);
    usart2.enable(CR1.RXNEIE);
}
