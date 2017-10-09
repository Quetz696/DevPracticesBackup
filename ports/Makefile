.SUFFIXES: .erl .beam .yrl

.erl.beam:
	erlc -W $<

MODS = example1

all: ${MODS:%=%.beam} example1 example1_drv.so


example1: example1.c erl_comm.c example1_driver.c
	gcc -o example1 example1.c erl_comm.c example1_driver.c

example1_drv.so:  example1.c
		gcc  -I /home/userone/Dev/practices/pragmatic\ programming/ports\
		-o example1_drv.so -fPIC -bundle -flat_namespace -undefined suppress\
		example1.c

clean:
	rm example1 example1_drv.so *.beam
