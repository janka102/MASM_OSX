CC=clang
CFLAGS=-Wall -g -arch i386 -lAlong32 -Llib -Wl,-no_pie

LDIR=lib
BDIR=bin

SRCS=$(wildcard *.asm)
BINS=$(addprefix $(BDIR)/,$(SRCS:.asm=))

all: $(BDIR) $(BINS)

$(BDIR)/%: $(BDIR)/%.macho
	$(CC) $< -o $@ $(CFLAGS)

$(BDIR)/%.macho: $(BDIR)/%.o
	$(LDIR)/objconv -fmac32 -nu $< $@

$(BDIR)/%.o: $(BDIR)/%.asm
	$(LDIR)/jwasm -nologo -zt0 -elf -Fo $@ $<

$(BDIR)/%.asm: %.asm
	cp $< $@
	perl -pi -e 's,Include Irvine32.inc,Include lib/Along32.inc,i' $@

$(BDIR):
	mkdir -p $(BDIR)

clean:
	rm -Rf $(BDIR)

.PHONY: all clean
