program test
    implicit none
    include 'mpif.h' ! incluing header
    integer :: ierr, nproc, rank 
    integer :: matrix(4,4) ! taking 4x4 as asked in question
    integer :: i,j, receiving(16),total_num_of_elements, first, last

    ! the 1st thing to do after including header and declaring vars
    call MPI_INIT(ierr) ! initialize the Library
    call MPI_COMM_SIZE(MPI_COMM_WORLD, nproc,ierr) ! num of processors is assigned to np var
    call MPI_COMM_RANK(MPI_COMM_WORLD, rank, ierr) ! rank of the process in id
    
    total_num_of_elements = 16
  
   if (rank == 0) then
        do i=1,4
            do j=1,4
                matrix(i,j) = 1
            enddo
        enddo
    endif
        
    
    call MPI_Scatter(matrix, 16/nproc, MPI_Int, receiving, 16/nproc, MPI_Int, 0, MPI_COMM_WORLD, ierr)


    write(*,*) "in process rank", rank, "received", receiving(:)

    call MPI_FINALIZE(ierr) ! to exit from MPI environment, free up memory


end program test