program test
    implicit none
    include 'mpif.h' ! incluing header
    integer :: ierr, nproc, rank ! checking for error
    integer:: nums(5)

    ! the 1st thing to do after including header and declaring vars
    call MPI_INIT(ierr) ! initialize the Library
    call MPI_COMM_SIZE(MPI_COMM_WORLD, nproc,ierr) ! num of processors is assigned to np var
    call MPI_COMM_RANK(MPI_COMM_WORLD, rank, ierr) ! rank of the process in id

   if (rank == 0) then
        read(*,*) nums(:)
        !write(*,*) nums(:) ! testing purpose
    endif
    
    ! broadcast it
    call MPI_Bcast(nums,5,MPI_INTEGER,0,MPI_COMM_WORLD,ierr)
    
    ! printing from all process other than root
    write(*,*) "process",rank,"nums are",nums(:)
    
    call MPI_FINALIZE(ierr) ! to exit from MPI environment, free up memory


end program test