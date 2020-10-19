program test
    implicit none
    include 'mpif.h'
    integer :: ierr, nproc, rank, i 
    real :: random_num,sum

    call MPI_INIT(ierr) 
    call MPI_COMM_SIZE(MPI_COMM_WORLD, nproc,ierr) ! num of processors is assigned to np var
    call MPI_COMM_RANK(MPI_COMM_WORLD, rank, ierr) ! rank of the process
    
    call random_seed()
    sum = 0.0
    do i=1,3
        call random_number(random_num)
        sum = sum + random_num
        ! debug statement to test that random numbers generated are same
        write(*,*) 'nums are', random_num
    end do
    write(*,*) "average in process of rank ", rank, "is ", sum/3000
    
    call MPI_FINALIZE(ierr) ! to exit from MPI environment, free up memory


end program test