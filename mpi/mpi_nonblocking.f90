program test
    implicit none
    include 'mpif.h' ! incluing header
    integer :: ierr, nproc, rank ! checking for error
    integer :: i, N, first, request(MPI_Status_Size),request1(MPI_Status_Size), status(MPI_Status_Size),status1(MPI_Status_Size)
    real :: nums(10000),sum, final_sum,other_sum,send_sum
    ! the 1st thing to do after including header and declaring vars
    call MPI_INIT(ierr) ! initialize the Library
    call MPI_COMM_SIZE(MPI_COMM_WORLD, nproc,ierr) ! num of processors is assigned to np var
    call MPI_COMM_RANK(MPI_COMM_WORLD, rank, ierr) ! rank of the process in id
    
    open(unit=1, file="random_numbers.dat", action="read", status="old")
    do i=1,10000
        read(1,*) nums(i)
    enddo
    close(1)

    sum = 0.0
    do i=1+rank,10000,nproc
        sum = sum + nums(i)
    enddo
  
    
   if(rank == 0) then
        call MPI_ISend(sum,1,MPI_Real,1,0,MPI_COMM_WORLD,request,ierr)
        call MPI_IRecv(final_sum,1,MPI_Real, nproc-1,nproc-1,MPI_COMM_WORLD,request,ierr)
        call MPI_Wait(request, status)
        write(*,*) "avg",final_sum/10000.0
    else 
        call MPI_IRecv(other_sum,1,MPI_Real, rank-1,rank-1,MPI_COMM_WORLD,request1,ierr)
        call MPI_Wait(request1, status1)
        !call MPI_Recv(other_sum,1, MPI_Real,rank-1,rank-1,MPI_COMM_WORLD,MPI_Status_Ignore,ierr)
        send_sum = sum + other_sum
        call MPI_ISend(send_sum,1,MPI_Real,Mod(rank+1,nproc),rank,MPI_COMM_WORLD,ierr)
    endif 
   
   
    

    call MPI_FINALIZE(ierr) ! to exit from MPI environment, free up memory


end program test