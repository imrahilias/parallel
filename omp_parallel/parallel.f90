! moritz siegel 220323

program parallel
  use omp_lib
  integer :: threads=0

  print*, "serial"

  !$omp parallel

  !$ threads = omp_get_num_threads()

  !$ print*, "running on thread", omp_get_thread_num()

  !$omp end parallel

  !$ print *, "running on ", threads, "threads"

end program parallel
