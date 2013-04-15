#include "recog.h"

// initialize buffer
int16_t buffer[BUF_SIZE];
int32_t buffer_index = 0;
int16_t current_value;

/*! \brief Adds the current value to the buffer
 *
 *  The current value should be set in the variable "current_value" first.
 *  This function is for compatibility with potentially different value-sizes (8 vs 16 or even 32 bits)
 *  and input methods.
 */
void buffer_add_current(void)
{
	buffer[buffer_index] = current_value;
	buffer_index++;
}

/*! \brief Clears the buffer
 *
 *  Sets all buffer values to 0. Resets the buffer index to 0.
 *  All current contents of the buffer will be lost.
 */
void buffer_clear(void)
{
	// clear the buffer
	memset(buffer, 0, BUF_SIZE);
	// set index to 0
	buffer_index = 0;
}
