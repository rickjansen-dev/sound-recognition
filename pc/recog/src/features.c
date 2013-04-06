#include "features.h"

/*! \brief Calculates HZCRR
 *
 *  Calculates the High Zero Crossing Rate Ratio. The HZCRR is a time-domain feature.
 */
uint8_t time_hzcrr()
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
		printf("DBG: JSTART: %d, JEND: %d",j_start, j_end);
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
		printf("DBG: FRAME_ZCR: %d\n",frame_zcr);
#endif
	}

	int average_zcr = total_zcr / FRAMES_PER_SAMPLE;

#if DEBUG
	printf("DBG: TOTAL_ZCR: %d\n",total_zcr);
	printf("DBG: AVG_ZCR: %d\n",average_zcr);
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
 */
uint8_t time_lster()
{
	// for each frame
	// 		determine avg(values)

	// determine avg(ste)
	// for each ste
	//		determine if ste < avg(ste)

	// output ratio


	return 0;
}

