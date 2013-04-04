#ifndef INPUT_H
#define INPUT_H

#include "recog.h"

/*! \brief Reads from source until nothing is available
 *
 *  Depending on the platform, this function will read from the for the platform appropriate source.
 *  For PC/Linux this could be stdin (using pipe to get output from sox for example)
 *  For Arduino Due this could be serial port (test/learning stage) or ADC (real life application using microphone)
 */
void read_input(void);

#endif
