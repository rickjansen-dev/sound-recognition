#include "haar.h"

int16_t Wfilters[] = {2,4,6,8,10,12,14,16,18,20};
int16_t number_of_filters = 10;
int16_t alpha = 1;
int16_t Wshift = 0;
int32_t IS_last_frame = 0;
int32_t IS_last_offset = 0;
int32_t IS[FRAME_SIZE];

void haar_process(void)
{
	// for each sample
	for (int i=0; i<FRAMES_PER_SAMPLE; i++)
	{
		haar_calc_IS(i);
		//xm_current_frame = {0,0,0,0,0};
		// for each filter
		for (int j=0; j<number_of_filters; j++)
		{
			Wshift = alpha * Wfilters[j];
			int32_t xm_current_filter = 0;
			int32_t onefiltervalue = 0;
			for (int n=0; n<((FRAME_SIZE-Wfilters[j])/Wshift + 1); n++)
			{
				onefiltervalue = IS[n+Wfilters[j]] - 2 * IS[n+Wfilters[j]/2] + IS[n];
				xm_current_filter += onefiltervalue;				
			}
			printf("filter wf = %d, value: %d\n",Wfilters[j],xm_current_filter);
		}
		
	}
}

void haar_calc_IS(int frame_number)
{
	int32_t ICurrent = IS_last_frame;
	//int32_t offset = frame_number * FRAME_SIZE;
	for (int l=IS_last_offset; l<IS_last_offset + FRAME_SIZE; l++)
	{
		ICurrent += buffer[l];
		IS[l-IS_last_offset] = ICurrent;
	}
	IS_last_offset = IS_last_offset + FRAME_SIZE;
	IS_last_frame = IS[FRAME_SIZE];
}
