program test
    implicit none
    include 'mpif.h' ! incluing header
    integer :: ierr ! checking for error

    ! the 1st thing to do after including header and declaring vars
    call MPI_INIT(ierr) ! initialize the Library
    write(*,*) 'hello'

    call MPI_FINALIZE(ierr) ! to exit from MPI environment, free up memory


end program test