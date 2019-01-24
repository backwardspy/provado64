p64.prg: main.s
	64tass -C -a -B -i -L p64.lst $< -o $@

clean:
	rm -f p64.prg p64.lst
