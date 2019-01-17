.PHONY: all clean

all: c64test.prg

c64test.prg: c64test.o
	pucrunch -ffast -x 2048 $< >$@

c64test.o: c64test.s
	64tass -C -a -B -i -L c64test.lst $< -o $@

clean:
	rm -f c64test.o c64test.prg c64test.lst
