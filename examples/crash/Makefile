TOP_DIR = $(shell while [ ! -f build/main.mk ]; do cd ..; done; pwd)
include $(TOP_DIR)/build/main.mk

.PHONY: all clean

TARGET = crash.bin

SRC = $(shell find ./ -name "*.d")
OBJ = app.o

LDCFLAGS = -mtriple=thumbv7em-none-linux-gnueabihf -betterC -c -g -defaultlib= -relocation-model=static -release
LDFLAGS = -T $(TOP_DIR)/layout.ld -nostartfiles

LIBRARY = stm32f407discovery
LINKFLAGS = \
	-I$(TOP_DIR)/source \
	-I${TOP_DIR}/cortexm/source

.SUFFIXES: .d .o

all: $(TARGET)

run: $(TARGET)
	@arm-none-eabi-gdb -q -iex "set auto-load safe-path ./" $(TARGET)

$(TARGET): $(OBJ)
	$(LD) $< $(LDFLAGS) -o $@ -L$(TOP_DIR) -l$(LIBRARY)

.d.o: $(SRC)
	$(LDC) $(LDCFLAGS) -op ${LINKFLAGS} $<

clean:
	$(RM) $(OBJ) $(TARGET)
