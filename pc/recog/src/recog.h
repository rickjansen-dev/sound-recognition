#ifndef RECOG_H
#define RECOG_H
 
// define sample rate, bit depth & sample size (in seconds)
#define SAMPLE_RATE 8000
#define BIT_DEPTH 8
#define SAMPLE_SIZE 1
#define FRAMES_PER_SAMPLE 40

// autodefine some settings based on defines above
#define BUF_SIZE SAMPLE_RATE * SAMPLE_SIZE
#define FRAME_SIZE SAMPLE_RATE / FRAMES_PER_SAMPLE

// include required std headers
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <stdint.h>

extern uint8_t buffer[BUF_SIZE];
extern uint8_t zcr[FRAMES_PER_SAMPLE];
extern uint8_t ste[FRAMES_PER_SAMPLE];

void print_buffer(ssize_t bytesread);
 
#endif
