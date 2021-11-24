program pingpongbandwidth

  use mpi_f08

  implicit none

  integer, parameter :: nummsg=50, scale=64, maxsize=2097152, proc0=0, proc1=1, ping=17, pong=23
  double precision :: start, finish, transfer, bandwidth
  type(mpi_status) :: status
  real,dimension(maxsize) :: buffer ! define maximum size, truncate when transmitting
  integer :: i, n, rank, size=8 ! beware of integer overflow

  call mpi_init()
  call mpi_comm_rank(mpi_comm_world, rank)

  ! test all sizes
  sizes : do while ( size .le. maxsize )
     
     ! init takes longer, exclude from benchmark?
     if (rank .eq. proc0) then
        write(*,*) 'buffer size:', size, ' bytes'
        call mpi_send(buffer, size, mpi_real, proc1, ping, mpi_comm_world)
        call mpi_recv(buffer, size, mpi_real, proc1, pong, mpi_comm_world, status)
     else if (rank .eq. proc1) then
        call mpi_recv(buffer, size, mpi_real, proc0, ping, mpi_comm_world, status)
        call mpi_send(buffer, size, mpi_real, proc0, pong, mpi_comm_world)
     end if

     start = mpi_wtime()

     msg : do i=1, nummsg
        if (rank .eq. proc0) then
           call mpi_send(buffer, size, mpi_real, proc1, ping, mpi_comm_world)
           call mpi_recv(buffer, size, mpi_real, proc1, pong, mpi_comm_world, status)
        else if (rank .eq. proc1) then
           call mpi_recv(buffer, size, mpi_real, proc0, ping, mpi_comm_world, status)
           call mpi_send(buffer, size, mpi_real, proc0, pong, mpi_comm_world)
        end if
     end do msg

     finish = mpi_wtime()

     if (rank .eq. proc0) then
        transfer = ((finish - start) / (2 * nummsg)) * 1e6  ! in microsec
        write(*,*) 'time for one message:', transfer, ' micro seconds'
        bandwidth = size / transfer  ! in megabytes/s
        write(*,*) 'bandwidth:', bandwidth, ' megabytes/s'
     end if

     ! scale buffer size
     size = size * scale ! in bytes

  end do sizes

  call mpi_finalize()

end program pingpongbandwidth
