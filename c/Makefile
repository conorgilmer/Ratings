CC=gcc
CFLAGS=-I.
DEPS = 
OBJ = ratingcalc.o 

%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

ratingcalc: $(OBJ)
	gcc -o $@ $^ $(CFLAGS)

