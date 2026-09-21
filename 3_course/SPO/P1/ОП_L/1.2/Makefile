all: libsolution.so

libsolution.so: solution.c
	gcc -shared -fPIC -o libsolution.so solution.c

clean:
	rm -f libsolution.so
