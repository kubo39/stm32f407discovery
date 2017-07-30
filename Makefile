include build/main.mk

.PHONY: all clean

TARGET = libstm32f407discovery.a

SRCS = \
	$(shell find ./source -name "*.d") \
	$(shell find ./cortexm/source -name "*.d")
OBJS = constants.o gpio.o rcc.o package.o cortexm.o assembly.o
OBJDIR = out
EXDIR = examples

LDCFLAGS = -mtriple=thumbv7em-none-linux-gnueabihf -defaultlib= -release -g -lib -od=$(OBJDIR) -of$(TARGET)

LINKFLAGS = \
	-I./source \
	-I./cortexm/source

all: $(TARGET)

$(TARGET): $(SRCS)
	$(LDC) $(LDCFLAGS) -op ${LINKFLGAS} $^

clean:
	$(RM) -r $(OBJDIR)/* $(TARGET)
	$(MAKE) -C $(EXDIR)/led clean

examples: $(TARGET)
	$(MAKE) -C $(EXDIR)/led

led-run: $(TARGET)
	$(MAKE) -C $(EXDIR)/led run
