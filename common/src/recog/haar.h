#ifndef HAAR_H
#define HAAR_H

#include "recog.h"

void haar_process();
void haar_calc_IS(int);

//define filters
extern int16_t Wfilters[];
extern int16_t number_of_filters;
extern int16_t alpha;
extern int16_t Wshift;
extern int32_t IS_last_frame;
extern int32_t IS_last_offset;
extern int32_t IS[FRAME_SIZE];

#endif
