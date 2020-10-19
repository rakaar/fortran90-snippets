program test
    implicit none

    include 'mpif.h' ! incluing header
    integer :: ierr, nproc, rank ! checking for error
    integer :: first

    integer :: i, j, skip_int
    real :: c_xyz(10000,3), o1_xyz(10000,3), o2_xyz(10000,3),dist1,dist2
    character(len=20) :: skip_text


    
    open(unit=1, file="co2.xyz", action="read", status="old")
    ! writting the distances to this file
    
    ! skipping the first 2 not uselful lines
    do j=1,10
        read(1, *) skip_int
        read(1, *) skip_text, skip_text, skip_text
            do i=1,1000
                ! reading carbon atom
                read(1, *) skip_text, c_xyz((j-1)*1000 + i,1), c_xyz((j-1)*1000 + i,2),c_xyz((j-1)*1000 + i,3)
                ! for 1st oxygen atom
                read(1, *) skip_text, o1_xyz((j-1)*1000 + i,1), o1_xyz((j-1)*1000 + i,2),o1_xyz((j-1)*1000 + i,3)
                
                ! for 2nd oxgen atom
                read(1, *) skip_text, o2_xyz((j-1)*1000 + i,1), o2_xyz((j-1)*1000 + i,2),o2_xyz((j-1)*1000 + i,3)
                
            end do
    end do

    call MPI_INIT(ierr) ! initialize the Library
    call MPI_COMM_SIZE(MPI_COMM_WORLD, nproc,ierr) ! num of processors is assigned to np var
    call MPI_COMM_RANK(MPI_COMM_WORLD, rank, ierr) ! rank of the process in id

    first = 1 + rank
    do i=first,10000,nproc
        dist1 = (((c_xyz(i,1) - o1_xyz(i,1))**2) + ((c_xyz(i,2) - o1_xyz(i,2))**2) + ((c_xyz(i,3) - o1_xyz(i,3))**2))**0.5
        dist2 = (((c_xyz(i,1) - o2_xyz(i,1))**2) + ((c_xyz(i,2) - o2_xyz(i,2))**2) + ((c_xyz(i,3) - o2_xyz(i,3))**2))**0.5
        write(*,*) "avg intra molecule dist CO2 num ",i,(dist1+dist2)/2 
    enddo

    call MPI_FINALIZE(ierr) ! to exit from MPI environment, free up memory


end program test