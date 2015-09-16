CC=clang
CFLAGS=-O0 -g -arch i386

LDIR=lib
BDIR=bin
TMP=tmp

SRCS=$(wildcard *.asm)
BINS=$(addprefix $(BDIR)/,$(SRCS:.asm=))

all: $(BDIR) $(TMP) bins
	rm -Rf $(TMP)

bins: $(BINS)

$(BDIR)/%: $(TMP)/%.macho
	$(CC) $< -o $@ $(CFLAGS)

$(TMP)/%.macho: $(TMP)/%.obj
	$(LDIR)/objconv -nr:__main@0:_main $< $@

$(TMP)/%.obj: $(TMP)/%.o
	$(LDIR)/objconv -fmac32 -nu+ $< $@

$(TMP)/%.o: $(TMP)/%.asm
	cd $(TMP); ../$(LDIR)/jwasm -nologo -elf $(notdir $<)

$(TMP)/%.asm: %.asm
	cp $< $@; perl -pi -e 's/invoke ExitProcess, ?0/ret/i' $@

$(BDIR):
	mkdir -p $(BDIR)

$(TMP):
	mkdir -p $(TMP)

clean:
	rm -Rf $(BDIR)

.PHONY: all clean bins
