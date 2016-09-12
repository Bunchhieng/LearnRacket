all:
	racket main.rkt >> actual.txt
clean:
	rm -f *~
	rm -f *#
	rm -f actual.txt
