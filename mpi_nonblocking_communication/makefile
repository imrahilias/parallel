.PHONY: all clean

all: ring_irecv ring_isend

clean:
	rm ring_irecv ring_irecv.log ring_isend ring_isend.log

ring_irecv: ring_irecv.f90
	mpif90 -o ring_irecv ring_irecv.f90
	mpirun -np 8 ./ring_irecv > ring_irecv.log

ring_isend: ring_isend.f90
	mpif90 -o ring_isend ring_isend.f90
	mpirun -np 8 ./ring_isend > ring_isend.log
