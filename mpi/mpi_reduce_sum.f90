program test
    implicit none
    include 'mpif.h' ! incluing header
    integer :: ierr, nproc, rank ! checking for error
    integer :: i, N, sum, final_sum, first, last
    ! the 1st thing to do after including header and declaring vars
    call MPI_INIT(ierr) ! initialize the Library
    call MPI_COMM_SIZE(MPI_COMM_WORLD, nproc,ierr) ! num of processors is assigned to np var
    call MPI_COMM_RANK(MPI_COMM_WORLD, rank, ierr) ! rank of the process in id
    
    N=100
    sum = 0
    first = 1+rank

    do i=first,N,nproc
        sum = sum + i
    enddo
    last = i  - (nproc)  
    write(*,*) "process:",rank, "sum is ", sum 
    
    ! reduce, send them to process 0,to evaluate final_sum
    final_sum = 0
    call MPI_Reduce(sum, final_sum, 1, MPI_INTEGER, MPI_SUM, 0, MPI_COMM_WORLD, ierr)
    if(rank == 0) then
        write(*,*) "final_sum is",final_sum
    endif

    call MPI_FINALIZE(ierr) ! to exit from MPI environment, free up memory


end program test