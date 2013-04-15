#include "features.h"

// initialize feature-buffers
int zcr[FRAMES_PER_SAMPLE];
int ste[FRAMES_PER_SAMPLE];

/*! \brief Calculates HZCRR
 *
 *  Calculates the High Zero Crossing Rate Ratio. The HZCRR is a time-domain feature.
 *  Does not modify the current buffer.
 */
uint8_t time_hzcrr(void)
{
	int total_zcr = 0;
	for (int i=0; i<FRAMES_PER_SAMPLE; i++)
	{
		int sign_current = 2;
		int sign_previous = 2;
		int frame_zcr = 0;

		int j_start = i*FRAME_SIZE;
		int j_end = j_start + FRAME_SIZE;
#if DEBUG
		printf("DBG: JSTART: %d, JEND: %d\r\n",j_start, j_end);
#endif
		for (int j=j_start; j<j_end; j++)
		{
			if (buffer[j] >= 0)
			{
				sign_current = 1;
			}
			else
			{
				sign_current = 0;
			}
			if (sign_current == 1 && sign_previous == 0)
				frame_zcr++;
			if (sign_current == 0 && sign_previous == 1)
				frame_zcr++;

			sign_previous = sign_current;
		}
		zcr[i] = frame_zcr;
		total_zcr += frame_zcr;
#if DEBUG
		//printf("DBG: FRAME_ZCR: %d\n",frame_zcr);
#endif
	}

	int average_zcr = total_zcr / FRAMES_PER_SAMPLE;

#if DEBUG
	printf("DBG: TOTAL_ZCR: %d\r\n",total_zcr);
	printf("DBG: AVG_ZCR: %d\r\n",average_zcr);
#endif
	uint8_t total_high = 0;
	uint8_t total_low = 0;
	for (int k=0; k<FRAMES_PER_SAMPLE; k++)
	{
		if (zcr[k] >= average_zcr)
		{
			total_high++;
		}
		else
		{
			total_low++;
		}
	}

	return total_high;
}

/*! \brief Calculates LSTER
 *
 *  Calculates the Low Short-Time Engery Ratio. The LSTER is a time-domain feature.
 *  Does not modify the current buffer.
 */
uint8_t time_lster(void)
{
	int64_t total_ste = 0;
	int frame_counter = 0;
	int frame_index = 0;
	int64_t frame_ste = 0;
	for (int i=0; i<BUF_SIZE; i++)
	{
		frame_ste += (int64_t)buffer[i] * (int64_t)buffer[i];
		
		
		
		frame_counter++;
		if (frame_counter == FRAME_SIZE)
		{
#if DEBUG
			printf("Frame (%d) STE: %lld\r\n",frame_index,frame_ste);
#endif
			ste[frame_index] = frame_ste;
			total_ste += frame_ste;
			frame_counter = 0;
			frame_index++;
			frame_ste = 0;						
		}
	}
	
	int average_ste = total_ste / FRAMES_PER_SAMPLE;
#if DEBUG
	printf("Total STE: %lld, Average STE: %d\r\n",total_ste,average_ste);
#endif

	// output ratio
	uint8_t total_high = 0;
	uint8_t total_low = 0;
	
	for (int j=0; j < FRAMES_PER_SAMPLE; j++)
	{
		if (ste[j] >= average_ste)
		{
			total_high++;
		}
		else
		{
			total_low++;
		}
	}


	return total_high;
}

