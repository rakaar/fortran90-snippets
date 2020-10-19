program test
    implicit none
    include 'mpif.h' ! incluing header
    integer :: ierr, nproc, rank ! checking for error
    integer:: i, flag, N, total_number_of_primes,first,local_number_of_primes

    call MPI_INIT(ierr) ! initialize the Library
    call MPI_COMM_SIZE(MPI_COMM_WORLD, nproc,ierr) ! num of processors is assigned to np var
    call MPI_COMM_RANK(MPI_COMM_WORLD, rank, ierr) ! rank of the process in id
    
    local_number_of_primes = 0
    N = 100
    first = 3+rank
    do i=first,N,nproc
        flag = 1
        call is_prime(i,flag)
        if (flag == 1) then
            local_number_of_primes = local_number_of_primes + 1
        endif
    enddo

    call MPI_Reduce(local_number_of_primes,total_number_of_primes,1,MPI_INTEGER,MPI_SUM,0,MPI_COMM_WORLD,ierr)
    if(rank==0) then
        write(*,*) "number of primes from 2 to",N,"is", total_number_of_primes+1 !+1 is for implicitly adding 2
    endif


    call MPI_FINALIZE(ierr) ! to exit from MPI environment, free up memory

end program test


subroutine is_prime(number,flag)
    implicit none
    integer:: number, flag
    integer:: i

    flag = 1
    do i=2,number-1
        if(mod(number,i) == 0) then
            flag = 0
            exit
        endif
    enddo

end subroutine is_prime