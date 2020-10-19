program test
    integer:: i, iters,index, score,stride,N, start_num, last, final_score,sign_for_exit_loop
    real :: nums(10000),new_num,old_num,predecor
    
    include 'mpif.h' ! incluing header
    integer :: ierr, nproc, rank ! checking for error
    call MPI_INIT(ierr) ! initialize the Library
    call MPI_COMM_SIZE(MPI_COMM_WORLD, nproc,ierr) ! num of processors is assigned to np var
    call MPI_COMM_RANK(MPI_COMM_WORLD, rank, ierr) ! rank of the process in id

    open(unit=1, file="random_numbers.dat", action="read", status="old")
    do i=1,10000
        read(1,*) nums(i)
    enddo
    close(1)

    sign_for_exit_loop = 0
    N = 9999 - 2 +1
    stride = (N)/nproc
    start_num = rank*stride + 2
    last = start_num -1 + stride

    if (rank == nproc - 1) then
        last = 9999
    end if
    iters = 0
    do
        score = 0
        do index=start_num,last
            predecor = nums(index-1)
            if(rank /=0 .and. index == start_num) then
                call MPI_Recv(predecor,1, MPI_Real,rank-1,MPI_Any_Tag,MPI_COMM_WORLD,MPI_STATUS_IGNORE,ierr)
            endif
            old_num = nums(index)
            new_num = (old_num + predecor + nums(index+1))/3.0  
            nums(index) = new_num
            if (abs(new_num - old_num) < 0.01) then
                score = score + 1
            endif
        enddo
    
        if(rank /= nproc-1) then
            call MPI_Send(nums(last),1,MPI_Real, rank+1,rank+1, MPI_COMM_WORLD, ierr)
        endif 
        
        iters = iters + 1
        
        ! waiting for all process, so that their score is calculated
        call MPI_Barrier(MPI_COMM_WORLD, ierr)
        call MPI_Reduce(score, final_score, 1, MPI_Int, MPI_SUM, 0, MPI_COMM_WORLD,ierr)
        
        ! the below if is for debugging purpose to know that code is running
        if(rank == 0) then
            write(*,*) "iters",iters
        endif
        if(final_score == 9998) then
            if(rank == 0) then
                write(*,*) "number of iters", iters,"final score",final_score
                call MPI_Abort(MPI_COMM_WORLD, ierr)
            endif
        endif
    enddo

call MPI_FINALIZE(ierr) ! to exit from MPI environment, free up memory

end program test