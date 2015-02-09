CC=g++
CFLAGS=-I.
DEPS = 
OBJ = chessrecords.o 

%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

chessrecords: $(OBJ)
	g++ -o $@ $^ $(CFLAGS)

