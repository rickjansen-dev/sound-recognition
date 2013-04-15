#ifndef FEATURES_H
#define FEATURES_H

// include global config header

#include "recog.h"

extern int zcr[FRAMES_PER_SAMPLE];
extern int ste[FRAMES_PER_SAMPLE];

uint8_t time_hzcrr(void);
uint8_t time_lster(void);

#endif
