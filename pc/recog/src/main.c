
#include "../../../common/src/recog/recog.h"
#include "../../../common/src/recog/features.h"
#include "../../../common/src/recog/haar.h"
#include "../../../common/src/recog/input.h"


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
				
				printf("HZCRR = %d/40\r\n",hzcrr);
				
				uint8_t lster = time_lster();
				
				printf("LSTER = %d/40\r\n",lster);
				
				haar_process();
				
				buffer_clear();
				
				//break;
			}
		}
	}
	
	
	
	
	//return 0;
}

