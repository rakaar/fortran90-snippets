program test
    implicit none
    include 'mpif.h' ! incluing header
    integer :: ierr, nproc, rank ! checking for error
    integer :: start_num,last,N, local_num_of_primes, total_number_primes, stride

    call MPI_INIT(ierr) ! initialize the Library
    call MPI_COMM_SIZE(MPI_COMM_WORLD, nproc,ierr) ! num of processors is assigned to np var
    call MPI_COMM_RANK(MPI_COMM_WORLD, rank, ierr) ! rank of the process in id

    ! calculating number of primes from 3 to end_num, here 100
    N = 100
    stride = (N - 3 + 1)/nproc
    
    start_num = rank*stride + 3 ! we implicitly include 2, hence starting from 3
    last = start_num -1 + stride

    if (rank == nproc - 1) then
        last = N
    end if

    call num_of_primes(start_num, last, local_num_of_primes)
    !write(*,*) "rank",rank, "1st->last", start_num, "->",last,"primes",local_num_of_primes
    ! reduce it
    call MPI_Reduce(local_num_of_primes, total_number_primes, 1, MPI_INTEGER, MPI_SUM, 0, MPI_COMM_WORLD, ierr)
    
    if (rank == 0) then
        write(*,*) "number of primes from 2 to",N,total_number_primes + 1 ! including "2" in count
    endif

    call MPI_FINALIZE(ierr) ! to exit from MPI environment, free up memory
end program test

subroutine num_of_primes(start_num,end_num,n)
    implicit none
    
    integer :: start_num,end_num,n
    integer :: i,j,flag ! for looping
    
    n = 0
    do i=start_num,end_num
        flag = 1
        do j=2,i-1
            if (mod(i,j) == 0) then !if the i has a divisor between 2 and i-1, then its not a prime
                flag = 0
                exit
            else 
                continue
            end if 
        end do
        
        if (flag == 1) then
            n = n + 1
        else 
            continue
        end if
    end do

end subroutine num_of_primes

