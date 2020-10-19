program test
    implicit none
    include 'mpif.h' ! incluing header
    integer :: ierr, nproc, rank ! checking for error
    integer :: i, N, sum, final_sum, first, last, other_sum,send_sum
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

   if(rank == 0) then
        call MPI_Send(sum,1,MPI_INT,1,0,MPI_COMM_WORLD,ierr)
        call MPI_Recv(final_sum,1,MPI_INT, nproc-1,nproc-1,MPI_COMM_WORLD,MPI_STATUS_IGNORE,ierr)
        write(*,*) "final sum received frm ",nproc-1, "is",final_sum
    else 
        call MPI_Recv(other_sum,1, MPI_INT,rank-1,rank-1,MPI_COMM_WORLD,MPI_STATUS_IGNORE,ierr)
        send_sum = sum + other_sum
        call MPI_Send(send_sum,1,MPI_INT,Mod(rank+1,nproc),rank,MPI_COMM_WORLD,ierr)
    endif 
   

    call MPI_FINALIZE(ierr) ! to exit from MPI environment, free up memory


end program test