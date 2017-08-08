include build/main.mk

.PHONY: all clean

TARGET = libstm32f407discovery.a

SRCS = \
	$(shell find ./source -name "*.d") \
	$(shell find ./cortexm/source -name "*.d")
OBJDIR = out
EXDIR = examples

LDCFLAGS = -mtriple=thumbv7em-none-linux-gnueabihf -defaultlib= -Oz -release -g -lib -od=$(OBJDIR) -of$(TARGET)

LINKFLAGS = \
	-I./source \
	-I./cortexm/source

all: $(TARGET)

$(TARGET): $(SRCS)
	$(LDC) $(LDCFLAGS) -op ${LINKFLGAS} $^

clean:
	$(RM) -r $(OBJDIR)/* $(TARGET)
	$(MAKE) -C $(EXDIR)/crash clean
	$(MAKE) -C $(EXDIR)/interrupt clean
	$(MAKE) -C $(EXDIR)/led clean

examples: $(TARGET)
	$(MAKE) -C $(EXDIR)/crash
	$(MAKE) -C $(EXDIR)/interrupt
	$(MAKE) -C $(EXDIR)/led

crash-run: $(TARGET)
	$(MAKE) -C $(EXDIR)/crash run

interrupt-run: $(TARGET)
	$(MAKE) -C $(EXDIR)/interrupt run

led-run: $(TARGET)
	$(MAKE) -C $(EXDIR)/led run
