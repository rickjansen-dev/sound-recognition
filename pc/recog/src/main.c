/*
 * main.c
 * 
 * Author: Rick Jansen
 * Last Modified: 1-apr-2013 23:55
 * 
 */

#include "recog.h"

int main(int argc, char **argv)
{
	ssize_t bytesread;
	while((bytesread = read(STDIN_FILENO, buffer, BUF_SIZE)))
	{
		print_buffer(bytesread);
		break;
	}
	
	printf("\nFinished\n");
	
	return 0;
}

