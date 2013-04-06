/*
 * main.c
 * 
 * Author: Rick Jansen
 * Last Modified: 1-apr-2013 23:55
 * 
 */

#include "recog.h"
#include "features.h"
#include "input.h"

int main(int argc, char **argv)
{
	// start the input processor
	while (1)
	{
		if (read_input())
		{
			buffer_add_current();
			if (buffer_index >= 8000)
			{
				uint8_t hzcrr = time_hzcrr();
				printf("HZCRR = %d/40\n",hzcrr);
				break;
			}
		}
	}
	
//	uint8_t hzcrr = time_hzcrr(127);

//	printf("\nFinished. HZCRR = %d\n",hzcrr);
	
	return 0;
}

