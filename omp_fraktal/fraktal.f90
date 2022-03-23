! moritz siegel 211021
! calculate newtons fractal

program fraktal
  use omp_lib
  implicit none
  integer, parameter :: p=selected_real_kind(16), dim=1024, maxiter=1e5
  integer :: threads=1, n, iterations(dim,dim)=0, row, col
  real(kind=p), parameter :: eps=1.e-16_p
  real(kind=p), parameter :: xi=-10._p, xe=-4._p, dx=abs(xi-xe)/real(dim,kind=p)
  real(kind=p), parameter :: yi=-2._p, ye=2._p, dy=abs(yi-ye)/real(dim,kind=p)
  real(kind=p) :: x, y, tic, toc
  complex(kind=p) :: z, z0

  open(unit=1, file="fraktal.dat")

  !! init
  call cpu_time(tic)
  !$ call omp_set_num_threads( 4 )
  !$ tic = omp_get_wtime()
  !$ threads = omp_get_max_threads()
  
  !$omp parallel do default(private) shared(iterations)
  do row = 1, dim
     x = xi + row * dx
     do col = 1, dim
        y = yi + col * dy

        z0 = cmplx( x, y, kind=p ) ! convert to retain precision, cmplx is unaware of kind!

        do n = 1,maxiter

           z = z0 - (z0**3 - 1._p)/(3._p*z0**2)

           if ( abs(z - z0) .lt. eps ) exit ! iterate until precision is obtained

           z0 = z

        end do

        iterations( row, col ) = n

     end do
  end do
  !$omp end parallel do

  !! timing
  call cpu_time(toc)
  !$ toc = omp_get_wtime()
  print *, "running on ", threads, "threads"
  print *, "work took", toc - tic, "seconds"
  print *, "maximum iterations: ", maxval(iterations)

  !! print in order
  do row = 1, dim
     x = xi + row * dx
     do col = 1, dim
        y = yi + col * dy
        write(1,*) x, y, iterations( row, col )
     end do
     write(1,*)
  end do

end program fraktal
