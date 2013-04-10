#include "recog.h"

// initialize buffers.
int16_t buffer[BUF_SIZE];
int32_t buffer_index = 0;
//int16_t bigbuffer[BUF_SIZE];
int zcr[FRAMES_PER_SAMPLE];
int ste[FRAMES_PER_SAMPLE];
int16_t current_value;

void buffer_add_current()
{
	buffer[buffer_index] = current_value;
	buffer_index++;
	//printf("%d ", current_value);
}
