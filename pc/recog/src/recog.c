#include "recog.h"

// initialize buffers.
uint8_t buffer[BUF_SIZE];
int zcr[FRAMES_PER_SAMPLE];
int ste[FRAMES_PER_SAMPLE];

void print_buffer(ssize_t bytesread)
{
	for (int i=0; i<bytesread; i++)
	{

		printf("%d ",buffer[i]);
	}
}
