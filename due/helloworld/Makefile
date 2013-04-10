#define the location of the arduino libraries
ARDUINO := /home/rick/programming/arduino
INCLUDE_DIRS := -I$(ARDUINO)/hardware/arduino/sam/system/libsam -I$(ARDUINO)/hardware/arduino/sam/system/CMSIS/Device/ATMEL -I$(ARDUINO)/hardware/arduino/sam/system/CMSIS/CMSIS/Include -I$(ARDUINO)/hardware/arduino/sam/cores/arduino -I$(ARDUINO)/hardware/arduino/sam/variants/arduino_due_x



# define which files to compile
C_FILES := $(wildcard src/*.c)
OBJ_FILES := $(addprefix obj/,$(notdir $(C_FILES:.c=.o)))
# define the compiler to use. only tested on GCC (bundled with Arduino)
CC := $(ARDUINO)/hardware/tools/g++_arm_none_eabi/bin/arm-none-eabi-gcc
OBJCOPY := $(ARDUINO)/hardware/tools/g++_arm_none_eabi/bin/arm-none-eabi-objcopy
# define the compiler flags to use. Again, only tested for GCC
# CFLAGS := -c -Wall -std=c99 -nostdlib $(INCLUDE_DIRS)
CFLAGS := -c -g -Os -w -std=c99 -ffunction-sections -fdata-sections -nostdlib --param max-inline-insns-single=500 -fno-rtti -fno-exceptions -Dprintf=iprintf -mcpu=cortex-m3 -DF_CPU=84000000L -DARDUINO=152 -D__SAM3X8E__ -mthumb -DUSB_PID=0x003e -DUSB_VID=0x2341 -DUSBCON $(INCLUDE_DIRS)
LDFLAGS := -Os -Wl,--gc-sections -mcpu=cortex-m3 -L/tmp/build6438788643818289928.tmp -L/home/rick/programming/arduino/hardware/arduino/sam/variants/arduino_due_x -L$(ARDUINO)/hardware/arduino/sam/variants/arduino_due_x -T/home/rick/programming/arduino/hardware/arduino/sam/variants/arduino_due_x/linker_scripts/gcc/flash.ld -lm -lgcc -mthumb -Wl,--cref -Wl,--check-sections -Wl,--gc-sections -Wl,--entry=Reset_Handler -Wl,--unresolved-symbols=report-all -Wl,--warn-common -Wl,--warn-section-align -Wl,--warn-unresolved-symbols

OBJDIR := obj
BINDIR := bin

#test -d $(OBJDIR) || mkdir $(OBJDIR)
#test -d $(BINDIR) || mkdir $(BINDIR)

all: $(BINDIR)/helloworld

$(BINDIR)/helloworld: $(OBJ_FILES) | $(BINDIR)
	$(CC) $(LDFLAGS) -o $@.elf $^ /tmp/build6438788643818289928.tmp/syscalls_sam3.c.o -I/home/rick/programming/arduino/hardware/arduino/sam/variants/arduino_due_x/libsam_sam3x8e_gcc_rel.a -I/tmp/build6438788643818289928.tmp/core.a
	$(OBJCOPY) -O binary $@.elf $@.bin

$(OBJDIR)/%.o: src/%.c | $(OBJDIR)
	$(CC) $(CFLAGS) -o $@ $<	

$(OBJDIR):
	test -d $(OBJDIR) || mkdir $(OBJDIR)

$(BINDIR):
	test -d $(BINDIR) || mkdir $(BINDIR)

clean:
	rm -rf $(BINDIR) $(OBJDIR)
	
upload:
	$(ARDUINO)/hardware/tools/bossac --port=ttyACM0 -U false -e -w -v -b $(BINDIR)/helloworld.bin -R 
