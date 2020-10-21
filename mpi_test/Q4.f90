program test
    implicit none
    include 'mpif.h' ! incluing header
    integer :: ierr, nproc, rank ! checking for error
    integer :: i, msg(1000),size
    real :: start_time, end_time
    ! the 1st thing to do after including header and declaring vars
    call MPI_INIT(ierr) ! initialize the Library
    call MPI_COMM_SIZE(MPI_COMM_WORLD, nproc,ierr) ! num of processors is assigned to np var
    call MPI_COMM_RANK(MPI_COMM_WORLD, rank, ierr) ! rank of the process in id
    
    size = 1000
    do i = 1,size
        msg(i) = 1
    enddo
    
    
    call cpu_time(start_time)
    if(rank == 0 .or. rank == 1) then
        do i=1,15000
            if(rank == 0) then
                
                call MPI_Send(msg, size, MPI_Int, 1, 10, MPI_COMM_WORLD, ierr)
                call MPI_Recv(msg, size, MPI_Int, 1, 10, MPI_COMM_WORLD, MPI_STATUS_IGNORE,ierr)
           endif

            if(rank == 1) then
                call MPI_Send(msg, size, MPI_Int, 0, 10, MPI_COMM_WORLD, ierr)
                call MPI_Recv(msg, size, MPI_Int, 0, 10, MPI_COMM_WORLD, MPI_STATUS_IGNORE,ierr)
           endif

        enddo
    endif
    call cpu_time(end_time)

    if(rank == 0 .or. rank == 1) then
        write(*,*) "rank", rank,"time", end_time-start_time
    endif

    call MPI_FINALIZE(ierr) ! to exit from MPI environment, free up memory


end program test