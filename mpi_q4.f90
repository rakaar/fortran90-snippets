program test
    implicit none
    include 'mpif.h' ! incluing header
    integer :: ierr, nproc, rank ! checking for error
    
    integer :: i, j, skip_int
    real :: c_xyz(3), o_xyz(3), dist1, dist2, sum_dist
    character(len=20) :: skip_text

    call MPI_INIT(ierr) ! initialize the Library
    call MPI_COMM_SIZE(MPI_COMM_WORLD, nproc,ierr) ! num of processors is assigned to np var
    call MPI_COMM_RANK(MPI_COMM_WORLD, rank, ierr) ! rank of the process in id

    open(unit=1, file="co2.xyz", action="read", status="old")
    ! writting the distances to this file
    
    ! skipping the first 2 not uselful lines
    do j=1,10
        read(1, *) skip_int
        read(1, *) skip_text, skip_text, skip_text
            do i=1,1000
                ! reading carbon atom
                read(1, *) skip_text, c_xyz(1), c_xyz(2),c_xyz(3)
                ! for 1st oxygen atom
                read(1, *) skip_text, o_xyz(1), o_xyz(2),o_xyz(3)
                
                if (rank == 0) then
                    dist1 = (((c_xyz(1) - o_xyz(1))**2) + ((c_xyz(2) - o_xyz(2))**2) + ((c_xyz(3) - o_xyz(3))**2))**0.5
                    call MPI_Reduce(dist1,sum_dist, 1,MPI_REAL, MPI_SUM,0,MPI_COMM_WORLD,ierr)
                endif 
                ! for 2nd oxgen atom
                
                read(1, *) skip_text, o_xyz(1), o_xyz(2),o_xyz(3)
                if (rank == 1) then    
                    dist2 = (((c_xyz(1) - o_xyz(1))**2) + ((c_xyz(2) - o_xyz(2))**2) + ((c_xyz(3) - o_xyz(3))**2))**0.5
                     call MPI_Reduce(dist2,sum_dist, 1,MPI_REAL, MPI_SUM,0,MPI_COMM_WORLD,ierr)
                endif

                if (rank == 0) then
                    write(*,*) "avg distance is",sum_dist/2
                endif
            end do
    end do

call MPI_FINALIZE(ierr) ! to exit from MPI environment, free up memory



end program test