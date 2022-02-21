# Just a basic makefile to quickly test that everyting is working, it just
# compiles the .o and the generator

MUSASHIFILES     = m68kcpu.c m68kdasm.c
MUSASHIGENCFILES = m68kops.c
MUSASHIGENHFILES = m68kops.h
MUSASHIGENERATOR = m68kmake
SOFTFLOATDIR     = softfloat/build/Linux-386-GCC
SOFTFLOATINCDIR  = softfloat/source/include

EXE =
EXEPATH = ./

.CFILES   = $(MAINFILES) $(OSDFILES) $(MUSASHIFILES) $(MUSASHIGENCFILES)
.OFILES   = $(.CFILES:%.c=%.o)
.AFILES   = softfloat.a

CC        = gcc
WARNINGS  = -Wall -Wextra -pedantic
CFLAGS    = $(WARNINGS)
LFLAGS    = $(WARNINGS)

DELETEFILES = $(MUSASHIGENCFILES) $(MUSASHIGENHFILES) $(.OFILES) $(TARGET) $(MUSASHIGENERATOR)$(EXE) $(.AFILES)


all: $(.OFILES) $(.AFILES)

clean:
	rm -f $(DELETEFILES)
	cd $(SOFTFLOATDIR); make clean

m68kcpu.o: $(MUSASHIGENHFILES) m68kfpu.c m68kmmu.h $(SOFTFLOATINCDIR)/softfloat.h

softfloat.a: 
	cd $(SOFTFLOATDIR); make && cp $(.AFILES) ../../..

$(MUSASHIGENCFILES) $(MUSASHIGENHFILES): $(MUSASHIGENERATOR)$(EXE)
	$(EXEPATH)$(MUSASHIGENERATOR)$(EXE)

$(MUSASHIGENERATOR)$(EXE):  $(MUSASHIGENERATOR).c
	$(CC) $(CFLAGS) -o  $(MUSASHIGENERATOR)$(EXE) $(MUSASHIGENERATOR).c
	