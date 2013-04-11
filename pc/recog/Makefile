# define which files to compile
C_FILES := $(wildcard ../../common/src/recog/*.c) $(wildcard src/*.c) 
OBJ_FILES := $(addprefix obj/,$(notdir $(C_FILES:.c=.o)))
# define include dirs to search for headers
#INCLUDE_DIRS := -I../../common/src/recog
# define the compiler to use. only tested on GCC
CC := gcc
# define the compiler flags to use. Again, only tested for GCC
CFLAGS := -c -Wall -std=c99 #$(INCLUDE_DIRS)

OBJDIR := obj
BINDIR := bin

#test -d $(OBJDIR) || mkdir $(OBJDIR)
#test -d $(BINDIR) || mkdir $(BINDIR)

all: $(BINDIR)/recog

$(BINDIR)/recog: $(OBJ_FILES) | $(BINDIR)
	$(CC) -o $@ $^

$(OBJDIR)/%.o: src/%.c | $(OBJDIR)
	$(CC) $(CFLAGS) -o $@ $<

$(OBJDIR)/%.o: ../../common/src/recog/%.c | $(OBJDIR)
	$(CC) $(CFLAGS) -o $@ $<	

$(OBJDIR):
	test -d $(OBJDIR) || mkdir $(OBJDIR)

$(BINDIR):
	test -d $(BINDIR) || mkdir $(BINDIR)

clean:
	rm -rf $(BINDIR) $(OBJDIR)
