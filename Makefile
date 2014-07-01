
para-bench: para-bench.c
	gcc -Wall -W -pipe -lgomp -fopenmp -o para-bench para-bench.c

runtests: para-bench
	@echo runtests
	@for paramethod in \
					serial \
					pthread \
					openmpnoschedule \
					openmpschedule \
					openmpscheduledynamic ; \
					do \
						echo analyse $$paramethod ; \
						rm -f $$paramethod.data ; \
						for matrixsize in 128 256 512 1024 ; \
						do \
						./para-bench 2 64 $$matrixsize $$paramethod >> $$paramethod.data ; \
						done \
					done

plot: runtests
	@echo make plots
	@make -f plot.make all

all: test

test: para-bench runtests plot

clean:
	rm -rf core para-bench *.data *.eps *.png *.pdf
