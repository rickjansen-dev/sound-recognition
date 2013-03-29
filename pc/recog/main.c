/*
 * main.c
 * 
 * Copyright 2013 Rick Jansen <rick@pholus>
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
 * MA 02110-1301, USA.
 * 
 * 
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define BUF_SIZE 1024

char buffer[BUF_SIZE];
size_t contentSize = 1;



int main(int argc, char **argv)
{
	char *content = malloc(sizeof(char) * BUF_SIZE);
	if(content == NULL)
	{
		perror("Failed to allocate content");
		exit(1);
	}
	content[0] = '\0'; // make null-terminated
	while(fgets(buffer, BUF_SIZE, stdin))
	{
		char *old = content;
		contentSize += strlen(buffer);
		content = realloc(content, contentSize);
		if(content == NULL)
		{
			perror("Failed to reallocate content");
			free(old);
			exit(2);
		}
		strcat(content, buffer);
	}
	
	printf("The buffer contains: %s\n",buffer);

	if(ferror(stdin))
	{
		free(content);
		perror("Error reading from stdin.");
		exit(3);
	}	
	
	return 0;
}

