program test
    implicit none
    include 'mpif.h' ! incluing header
    integer :: ierr, np, id ! checking for error

    ! the 1st thing to do after including header and declaring vars
    call MPI_INIT(ierr) ! initialize the Library
    call MPI_COMM_SIZE(MPI_COMM_WORLD, np,ierr) ! num of processors is assigned to np var
    call MPI_COMM_RANK(MPI_COMM_WORLD, id, ierr) ! rank of the process in id
    ! write only for even process
    if (Mod(id,2) == 0) then
        write(*,*) "even id is", id, "out of", np
    endif

    ! print only last one
     if (id == np - 1) then
        write(*,*) "even id is", id, "out of", np
    endif

    call MPI_FINALIZE(ierr) ! to exit from MPI environment, free up memory


end program test