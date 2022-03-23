program ring

  use mpi_f08
  implicit none

  integer, parameter :: dim=2
  integer, dimension(dim) :: dims=0, my_coords=0
  integer :: my_rank, size, right, left, i, sum, rcv_buf, ierror
  integer :: direction, disp, rank_source, rank_dest
  integer, asynchronous :: snd_buf
  logical :: reorder=.true., periods(dim)
  type(mpi_status)  :: status
  type(mpi_request) :: request
  type(mpi_comm ) :: comm_old, comm_cart

  call mpi_init()
  call mpi_comm_rank(mpi_comm_world, my_rank)
  call mpi_comm_size(mpi_comm_world, size)

  ! create 2d cylinder cart topology & assign rank & coords.
  periods(1) = .true.
  periods(2) = .false.                                                                                             
  call mpi_dims_create(size, dim, dims, ierror)
  call mpi_cart_create(mpi_comm_world, dim, dims, periods, reorder, comm_cart, ierror)
  call mpi_comm_rank(comm_cart, my_rank, ierror)
  call mpi_cart_coords(comm_cart, my_rank, dim, my_coords, ierror)

  ! get nearest neighbour ranks.
  direction=0
  disp=1
  call mpi_cart_shift(comm_cart, direction, disp, rank_source, rank_dest, ierror)

  ! the halo ring communication code from course chapter 4
  sum = 0
  snd_buf = my_rank
  do i = 1, size
     call mpi_issend(snd_buf, 1, mpi_integer, rank_source, 17, comm_cart, request)
     call mpi_recv  (rcv_buf, 1, mpi_integer, rank_dest,  17, comm_cart, status)
     call mpi_wait(request, status)
     if (.not.mpi_async_protects_nonblocking) call mpi_f_sync_reg(snd_buf)
     snd_buf = rcv_buf
     sum = sum + rcv_buf
  end do
  write(*,*) "proc", my_rank, ": sum =", sum, "coords =", my_coords, "source/dest =", rank_source, rank_dest

  call mpi_finalize()

end program ring
