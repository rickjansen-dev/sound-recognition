/*
 * main.c
 * 
 * Author: Rick Jansen
 * Last Modified: 1-apr-2013 23:55
 * 
 */

#include "../../../common/src/recog/recog.h"
#include "../../../common/src/recog/features.h"
#include "../../../common/src/recog/input.h"
//#include <sys/time.h>

int main(int argc, char **argv)
{
	//struct timeval tim;


	printf("Start time: %d", t1);

	// start the input processor
	while (1)
	{
		if (read_input())
		{
			buffer_add_current();
			if (buffer_index >= 8000)
			{
				//gettimeofday(&tim, NULL);
				//suseconds_t t1 = tim.tv_usec;
				uint8_t hzcrr = time_hzcrr();
				//sleep(1);
				//gettimeofday(&tim, NULL);
				//suseconds_t t2 = tim.tv_usec - t1;
				printf("HZCRR = %d/40\nTime taken: %u ticks\n",hzcrr,t2);
				break;
			}
		}
	}
	
//	uint8_t hzcrr = time_hzcrr(127);

//	printf("\nFinished. HZCRR = %d\n",hzcrr);
	
	return 0;
}

