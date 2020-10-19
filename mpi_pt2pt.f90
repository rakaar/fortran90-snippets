program test
    implicit none
    integer :: nums(5),i

    include 'mpif.h' ! incluing header
    integer :: ierr, nproc, rank ! checking for error

    call MPI_INIT(ierr) ! initialize the Library
    call MPI_COMM_SIZE(MPI_COMM_WORLD, nproc,ierr) ! num of processors is assigned to np var
    call MPI_COMM_RANK(MPI_COMM_WORLD, rank, ierr) ! rank of the process in id
    
    if(rank == 0) then
        write(*,*) "write 5 nums"
        read(*,*) nums(:)
        do i=1,nproc-1
            call MPI_Send(nums,5,MPI_INT, i,1, MPI_COMM_WORLD, ierr)
        enddo
    else
        call MPI_Recv(nums, 5, MPI_INT, 0, MPI_ANY_TAG, MPI_COMM_WORLD, MPI_Status_Ignore, ierr)
        write(*,*) rank,"prints", nums(:)
    endif
! MPI_ANY_TAG can be used only with MPI_Recv
! MPI_ANY_SOURCE is used in MPI_Send in place of MPI_Any_Tag
    


    call MPI_FINALIZE(ierr) ! to exit from MPI environment, free up memory

    
    
end program test