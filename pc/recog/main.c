/*
 * main.c
 * 
 * Author: Rick Jansen
 * Last Modified: 1-apr-2013 23:55
 * 
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "recog.h"

#define SAMPLE_RATE 8000
#define BIT_DEPTH 16
#define SAMPLE_SIZE 1
#define BUF_SIZE 8192

int buffer[BUF_SIZE];
//int* buffer_pointer = &buffer[0];

void print_buffer()
{
	for (int i=0; i<BUF_SIZE; i++)
	{
		
		printf("%d ",buffer[i]);
	}
}

int main(int argc, char **argv)
{
	while(read(STDIN_FILENO, buffer, BUF_SIZE))
	{
		print_buffer();
		break;
	}
	
	printf("\nFinished\n");
	
	return 0;
}

