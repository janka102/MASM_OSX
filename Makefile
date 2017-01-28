CC=clang
CFLAGS=-Wall -O0 -g -arch i386 -lAlong32 -Llib -Wl,-no_pie

LDIR=lib
BDIR=bin

SRCS=$(wildcard *.asm)
BINS=$(addprefix $(BDIR)/,$(SRCS:.asm=))

all: $(BINS)

$(BDIR)/%: $(BDIR)/%.macho
	$(CC) $< -o $@ $(CFLAGS)

$(BDIR)/%.macho: $(BDIR)/%.o
	$(LDIR)/objconv -fmac32 -nu $< $@

$(BDIR)/%.o: $(BDIR)/%.asm
	$(LDIR)/jwasm -nologo -zt0 -elf -Fo $@ $<

$(BDIR)/%.asm: %.asm
	mkdir -p $(BDIR)
	cp $< $@
	perl -pi -e 's,Include Irvine32.inc,Include lib/Along32.inc,i' $@

clean:
	rm -Rf $(BDIR)

.PHONY: all clean
