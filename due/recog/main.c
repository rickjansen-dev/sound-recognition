#include "asf.h"
#include "stdio_serial.h"
#include "conf_board.h"
#include "conf_clock.h"

#include "recog.h"
#include "features.h"
#include "input.h"

#define STRING_EOL    "\r"
#define STRING_HEADER "-- Hello World --\r\n" \
		"-- "BOARD_NAME" --\r\n" \
		"-- Compiled: "__DATE__" "__TIME__" --"STRING_EOL

int toggle_firstbit = 0;

/**
 *  Configure UART console.
 */
static void configure_console(void)
{
	const usart_serial_options_t uart_serial_options = {
		.baudrate = CONF_UART_BAUDRATE,
		.paritytype = CONF_UART_PARITY
	};

	/* Configure console UART. */
	sysclk_enable_peripheral_clock(CONSOLE_UART_ID);
	stdio_serial_init(CONF_UART, &uart_serial_options);
	uart_enable_rx(CONF_UART);
}

int read_input_uart()
{
	uint8_t current_char = 0;

	if(!uart_read(CONF_UART, &current_char))
	{
		//printf("Got %d",current_char);
		if (toggle_firstbit == 0)
		{
			current_value = 0;
			current_value |= current_char & 0xFF;
    			current_value <<= 8;
			toggle_firstbit++;
			return 0;
		} 
		else 
		{
			current_value |= current_char & 0xFF;
			return 1;
		}
	}

	return 0;
}


int main(int argc, char **argv)
{
	/* Initialize the SAM system */
	sysclk_init();
	board_init();

	/* Initialize the console uart */
	configure_console();

	/* Output example information */
	puts(STRING_HEADER);


	// start the input processor
	while (1)
	{
		if (read_input())
		{
			//printf("Got %d",current_value);
			buffer_add_current();
			if (buffer_index >= 8000)
			{
				puts("1-second sample received.\r\n");
				uint8_t hzcrr = time_hzcrr();
				printf("HZCRR = %d/40\r\n",hzcrr);
				break;
			}
		}
	}

	puts("Finished. Entering endless loop...\r\n");
	
//	uint8_t hzcrr = time_hzcrr(127);

//	printf("\nFinished. HZCRR = %d\n",hzcrr);
	

	while(1)
	{
		; // endless loop to prevent uC from doing evil things
	}

}

