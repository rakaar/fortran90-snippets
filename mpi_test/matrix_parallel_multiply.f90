program test
    implicit none
    include 'mpif.h' ! incluing header
    integer :: ierr, nproc, rank ! checking for error
    integer :: m,n,p,i,j,k
    real, allocatable :: matrix1(:,:),matrix2(:,:),result(:,:)
    ! the 1st thing to do after including header and declaring vars
    call MPI_INIT(ierr) ! initialize the Library
    call MPI_COMM_SIZE(MPI_COMM_WORLD, nproc,ierr) ! num of processors is assigned to np var
    call MPI_COMM_RANK(MPI_COMM_WORLD, rank, ierr) ! rank of the process in id

    if (rank == 0) then
        write(*,*) "enter m,n,p"
        read(*,*) m,n,p 
        !write(*,*) m,n,p  
        
        !matrix 1 random intializeation
        allocate(matrix1(m,n))
        do i = 1,m
            do j=1,n
                matrix1(i,j) = rand()
            enddo
        enddo

        !matrix 2 random intializeation
        allocate(matrix2(n,p))
         do i = 1,n
            do j=1,p
                matrix2(i,j) = rand()
            enddo
        enddo
       
    endif
   
  

    call MPI_Barrier(MPI_COMM_WORLD, ierr)
    
    call MPI_Bcast(m, 1, MPI_Int, 0, MPI_COMM_WORLD, ierr)
    call MPI_Bcast(n, 1, MPI_Int, 0, MPI_COMM_WORLD, ierr)
    call MPI_Bcast(p, 1, MPI_Int, 0, MPI_COMM_WORLD, ierr)
     if(rank /= 0) then
        allocate(matrix1(m,n))
        allocate(matrix2(n,p))
   endif
    call MPI_Barrier(MPI_COMM_WORLD, ierr)

    call MPI_Bcast(matrix1, m*n, MPI_Real, 0, MPI_COMM_WORLD, ierr)
    call MPI_Bcast(matrix2, n*p, MPI_Real, 0, MPI_COMM_WORLD, ierr)
    
    
    
    call MPI_Barrier(MPI_COMM_WORLD, ierr)

    allocate(result(m,p))
    do i=1,m
        do j=1,p
            result(i,j) = 0.0
        enddo
    enddo
    call MPI_Barrier(MPI_COMM_WORLD, ierr)
    
    !----- sequential for debugging only ----
    if(rank == 0) then
        do i=1,m
            do j=1,p
                do k=1,n
                    result(i,j) = result(i,j) + matrix1(i,k)*matrix2(k,j)
                enddo
            enddo
        enddo 
     write(*,*) "seq result"
    do i=1,m
        do j=1,p
                write(*,*) "seq matrix","row", i, "col",j,result(i,j)
        enddo
    enddo
    endif
    
    call MPI_Barrier(MPI_COMM_WORLD, ierr)
    ! --- end of debugging code ---

    ! keeping all of them of result matrix 0 again
    do i=1,m
        do j=1,p
            result(i,j) = 0.0
        enddo
    enddo
    call MPI_Barrier(MPI_COMM_WORLD, ierr)

    
    ! here the basic idea is to divide the rows into different process
    ! perform the  parallel matrix multiplication
    do i=1+rank,m,nproc
        do j=1,p
            do k=1,n
                result(i,j) = result(i,j) + matrix1(i,k)*matrix2(k,j)
            enddo
        enddo
    enddo
    call MPI_Barrier(MPI_COMM_WORLD, ierr)

    ! print the result
     do i=1+rank,m,nproc
        do j=1,p
                write(*,*) "result matrix","row", i, "col",j,result(i,j)
        enddo
    enddo

    
    call MPI_FINALIZE(ierr) ! to exit from MPI environment, free up memory


end program test