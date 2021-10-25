.PHONY: all clean

all: fraktal

clean:
	rm fraktal fraktal.png fraktal.dat fraktal.log

fraktal: fraktal.f90 fraktal.gp
	gfortran -Og -Wall -fimplicit-none -fcheck=all -fbacktrace -fopenmp -o fraktal fraktal.f90
	./fraktal > fraktal.log
	gnuplot fraktal.gp	
