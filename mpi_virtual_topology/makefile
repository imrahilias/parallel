.PHONY: all clean

all: cart_create cart_shift cart_cyl

clean:
	rm cart_create cart_create.log cart_shift cart_shift.log cart_cyl cart_cyl.log

cart_create: cart_create.f90
	mpif90 -o cart_create cart_create.f90
	mpirun -np 8 ./cart_create > cart_create.log

cart_shift: cart_shift.f90
	mpif90 -o cart_shift cart_shift.f90
	mpirun -np 8 ./cart_shift > cart_shift.log

cart_cyl: cart_cyl.f90
	mpif90 -o cart_cyl cart_cyl.f90
	mpirun -np 8 ./cart_cyl > cart_cyl.log
