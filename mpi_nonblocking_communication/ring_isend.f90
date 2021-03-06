program ring

  use mpi_f08
  implicit none

  integer :: rank, size, right, left, i, sum
  integer, asynchronous :: sndbuf, rcvbuf
  type(mpi_status)  :: status
  type(mpi_request) :: request
  
  call mpi_init()
  call mpi_comm_rank(mpi_comm_world, rank)
  call mpi_comm_size(mpi_comm_world, size)
  right = mod(rank+1,      size)
  left  = mod(rank-1+size, size)

  sum = 0
  sndbuf = rank
  do i = 1, size
     call mpi_issend(sndbuf, 1, mpi_integer, right, 17, mpi_comm_world, request) ! first send, then recieve.
     call mpi_recv(rcvbuf, 1, mpi_integer, left,  17, mpi_comm_world, status)
     call mpi_wait(request, status) ! do not write to the same buffer between isend()/irecv() and wait().
     if (.not. mpi_async_protects_nonblocking) call mpi_f_sync_reg( sndbuf ) ! protect the buffer used in irecv().
     
     sndbuf = rcvbuf
     sum = sum + rcvbuf
  end do
  write(*,*) "p", rank, ": sum =", sum

  call mpi_finalize()

end program ring
