program test
    implicit none
    include 'mpif.h'
    integer :: ierr, nproc, rank 

    call MPI_INIT(ierr) 
    call MPI_COMM_SIZE(MPI_COMM_WORLD, nproc,ierr) ! num of processors is assigned to np var
    call MPI_COMM_RANK(MPI_COMM_WORLD, rank, ierr) ! rank of the process
    
    if (Mod(rank,3) == 0) then
        write(*,*) "Successful", "rank is ", rank
    end if
    
    call MPI_FINALIZE(ierr) ! to exit from MPI environment, free up memory


end program test