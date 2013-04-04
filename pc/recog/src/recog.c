#include "recog.h"

uint8_t buffer[BUF_SIZE];
uint8_t zcr[FRAMES_PER_SAMPLE];
uint8_t ste[FRAMES_PER_SAMPLE];

void print_buffer(ssize_t bytesread)
{
	for (int i=0; i<bytesread; i++)
	{

		printf("%d ",buffer[i]);
	}
}
