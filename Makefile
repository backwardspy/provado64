TARGET=p64.prg
OBJ=$(TARGET:%.prg=%.o)
MAIN=main.s
LST=$(MAIN:%.s=%.lst)
EXTRA_SRC=input.s

.PHONY: all clean

all: $(TARGET)

$(TARGET): $(OBJ)
	pucrunch -ffast -x 2048 $< > $@

$(OBJ): $(MAIN) $(EXTRA_SRC)
	64tass -C -a -B -i -L $(LST) $< -o $@

clean:
	rm -f $(OBJ) $(LST) $(TARGET)
