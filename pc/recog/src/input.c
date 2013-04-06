#include "input.h"

/*! \brief Reads from source (=stdin) until nothing is available
 *
 *  This PC/Linux implementation of read_input reads from stdin. Should be combined with utility 'sox'
 *  (by piping raw output to this util)
 */
size_t read_input(void)
{
	size_t result = read(STDIN_FILENO, &current_value, sizeof(current_value));

	return result;
}
