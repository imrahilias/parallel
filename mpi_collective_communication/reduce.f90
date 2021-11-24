program ring_reduce

  use mpi_f08
  implicit none

  integer :: rank, size, right, left, i, sum=0
  integer, parameter :: root=0
  type(mpi_status)  :: status
  
  call mpi_init()
  call mpi_comm_rank(mpi_comm_world, rank)
  call mpi_comm_size(mpi_comm_world, size)

  !! reduce | allreduce
  ! call mpi_reduce(rank, sum, 1, mpi_integer, mpi_sum, root, mpi_comm_world)
  call mpi_allreduce(rank, sum, 1, mpi_integer, mpi_sum, mpi_comm_world) ! allreduce does not need a root, the result goes to all processes anyway. 
  
  write(*,*) "sum =", sum
 
  call mpi_finalize()

end program ring_reduce
