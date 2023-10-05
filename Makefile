
C_OBJECTS = asciiArtProgram.o  netpbm.o
ASM_OBJECTS = colortogray.o calculatescale.o findminmax.o asciiart.o

asciiart: $(C_OBJECTS) $(ASM_OBJECTS)
	gcc -g -o asciiart $(C_OBJECTS) $(ASM_OBJECTS)

.c.o:
	gcc -I. -g -c $<

.S.o:
	gcc -I. -g -c $< 

clean:
	rm -f *.o asciiart *~ *.pgm

