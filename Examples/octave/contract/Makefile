TOP        = ../..
SWIG       = $(TOP)/../preinst-swig
SRCS       = example.c
TARGET     = example
INTERFACE  = example.i

all::
	$(MAKE) -f $(TOP)/Makefile SRCS='$(SRCS)' SWIG='$(SWIG)' \
	TARGET='$(TARGET)' INTERFACE='$(INTERFACE)' octave

static::
	$(MAKE) -f $(TOP)/Makefile SRCS='$(SRCS)' SWIG='$(SWIG)' \
	TARGET='myoctave' INTERFACE='$(INTERFACE)' octave_static

clean::
	$(MAKE) -f $(TOP)/Makefile octave_clean
	rm -f $(TARGET).py

check: all
	$(MAKE) -f $(TOP)/Makefile octave_run
