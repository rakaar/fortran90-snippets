program test
    implicit none
    include 'mpif.h' ! incluing header
    integer :: ierr, nproc, rank, msg, tag! checking for error

    ! the 1st thing to do after including header and declaring vars
    call MPI_INIT(ierr) ! initialize the Library
    call MPI_COMM_SIZE(MPI_COMM_WORLD, nproc,ierr) ! num of processors is assigned to np var
    call MPI_COMM_RANK(MPI_COMM_WORLD, rank, ierr) ! rank of the process in id
    
    ! here tag will the rank of the sender
    if(rank == 0) then
        msg = 10
        call MPI_Send(msg,1,MPI_INT,1,0,MPI_COMM_WORLD,ierr)
        call MPI_Recv(msg,1,MPI_INT, nproc-1,nproc-1,MPI_COMM_WORLD,MPI_STATUS_IGNORE,ierr)
        write(*,*) rank,"recieved from", nproc-1
    else 
        call MPI_Recv(msg,1, MPI_INT,rank-1,rank-1,MPI_COMM_WORLD,MPI_STATUS_IGNORE,ierr)
        write(*,*) rank,"recieved from",rank-1
        call MPI_Send(msg,1,MPI_INT,Mod(rank+1,nproc),rank,MPI_COMM_WORLD,ierr)
    endif  
    
    
    
    call MPI_FINALIZE(ierr) ! to exit from MPI environment, free up memory


end program test