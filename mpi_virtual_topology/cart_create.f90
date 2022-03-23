program ring

  use mpi_f08
  implicit none

  integer :: my_rank, size, right, left, i, sum, rcv_buf, ndims, dims(1), my_coords(1), ierror
  logical :: reorder, periods(1)
  integer, asynchronous :: snd_buf
  type(mpi_status)  :: status
  type(mpi_request) :: request
  type(mpi_comm ) :: comm_old, comm_cart

  call mpi_init()
  call mpi_comm_rank(mpi_comm_world, my_rank)
  call mpi_comm_size(mpi_comm_world, size)

  ! prepare input arguments for creating a cartesian topology.                                                                                                                                                     
  ndims = 1
  dims(1) = size
  periods(1) = .true.
  reorder = .true.

  ! create cart topology & assign rank & coords.                                                                                                                                                                   
  call mpi_cart_create(mpi_comm_world, ndims, dims, periods, reorder, comm_cart, ierror)
  call mpi_comm_rank(comm_cart, my_rank, ierror)
  call mpi_cart_coords(comm_cart, my_rank, ndims, my_coords, ierror)

  ! get nearest neighbour ranks.                                                                                                                                                                                   
  right = mod(my_rank+1,      size)
  left  = mod(my_rank-1+size, size)

  ! the halo ring communication code from course chapter 4                                                                                                                                                         
  sum = 0
  snd_buf = my_rank
  do i = 1, size
     call mpi_issend(snd_buf, 1, mpi_integer, right, 17, comm_cart, request)
     call mpi_recv  (rcv_buf, 1, mpi_integer, left,  17, comm_cart, status)
     call mpi_wait(request, status)
     if (.not.mpi_async_protects_nonblocking) call mpi_f_sync_reg(snd_buf)
     snd_buf = rcv_buf
     sum = sum + rcv_buf
  end do
  write(*,*) "proc", my_rank, ": sum =", sum, "coords =", my_coords

  call mpi_finalize()

end program ring
