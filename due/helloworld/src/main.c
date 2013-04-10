
//#define printf iprintf
//#define F_CPU 84000000L
//#define ARDUINO 152
//#define __SAM3X8E__ 
//#define USB_PID 0x003e
//#define USB_VID 0×2341
//#define USBCON

#include "Arduino.h"
//#include "chip.h"
#include "variant.h"

void USART_START()
{
	pmc_enable_periph_clk( ID_USART0 ) ;

  // Disable PDC channel
  USART0->US_PTCR = US_PTCR_RXTDIS | US_PTCR_TXTDIS ;

  // Reset and disable receiver and transmitter
  USART0->US_CR = US_CR_RSTRX | US_CR_RSTTX | US_CR_RXDIS | US_CR_TXDIS ;

  // Configure mode
  USART0->US_MR = US_MR_USART_MODE_NORMAL | US_MR_USCLKS_MCK | US_MR_CHRL_8_BIT | US_MR_PAR_NO |
                   US_MR_NBSTOP_1_BIT | US_MR_CHMODE_NORMAL;

  // Configure baudrate, asynchronous no oversampling
  USART0->US_BRGR = (SystemCoreClock / 9600) / 16 ;

  // Configure interrupts
  USART0->US_IDR = 0xFFFFFFFF;
  USART0->US_IER = US_IER_RXRDY | US_IER_OVRE | US_IER_FRAME;

  // Enable UART interrupt in NVIC
  NVIC_EnableIRQ( USART0_IRQn ) ;

  // Enable receiver and transmitter
  USART0->US_CR = US_CR_RXEN | US_CR_TXEN ;
}

int main(void)
{
	//WDT_Disable( WDT );
	
	//pmc_enable_periph_clk(ID_USART0);
	//USART_Configure(USART0, USART_MODE_ASYNCHRONOUS, 9600, SystemCoreClock);
	//USART_Configure(USART1, USART_MODE_ASYNCHRONOUS, 9600, F_CPU);	
	//USART_SetTransmitterEnabled(USART0, 1);
	//USART_SetReceiverEnabled(USART0, 1);
	//USART_SetTransmitterEnabled(USART1, 1);
	USART_START();
	
	int i =0;
	while (i < 255)
	{
		USART_PutChar(USART0, 65);
		//USART_Write(USART1, 65, 0);
		//USART_Write(USART0, 65, 0);

		i++;
	}
	

    return(0);
}


