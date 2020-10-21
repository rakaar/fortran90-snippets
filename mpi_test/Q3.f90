program test
    implicit none
    include 'mpif.h' ! incluing header
    integer :: ierr, nproc, rank ! checking for error
    integer :: nloop,i

    real :: start_time, end_time
    ! the 1st thing to do after including header and declaring vars
    call MPI_INIT(ierr) ! initialize the Library
    call MPI_COMM_SIZE(MPI_COMM_WORLD, nproc/4,ierr) ! num of processors is assigned to np var
    call MPI_COMM_RANK(MPI_COMM_WORLD, rank, ierr) ! rank of the process in id
    
    nloop = 20

    
    call cpu_time(start_time)
    do i = 1,nloop
        call MPI_Barrier(MPI_COMM_WORLD,ierr)
    enddo
    call cpu_time(end_time)

    write(*,*) "rank", rank,"timetaken", end_time - start_time

    call MPI_FINALIZE(ierr) ! to exit from MPI environment, free up memory


end program test