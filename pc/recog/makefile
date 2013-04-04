# define which files to compile
C_FILES := $(wildcard src/*.c)
OBJ_FILES := $(addprefix obj/,$(notdir $(C_FILES:.c=.o)))
# define the compiler to use. only tested on GCC
CC=gcc
# define the compiler flags to use. Again, only tested for GCC
CFLAGS=-c -Wall -std=c99

all: bin/recog

bin/recog: $(OBJ_FILES)
	$(CC) -o $@ $^

obj/%.o: src/%.c
	$(CC) $(CFLAGS) -o $@ $<

clean:
	rm -rf bin/* obj/*
