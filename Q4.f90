program test
    implicit none
    integer :: i, j, skip_int
    real :: c_xyz(3), o_xyz(3), dist
    character(len=20) :: skip_text

    open(unit=1, file="co2.xyz", action="read", status="old")
    ! writting the distances to this file
    open(unit=2, file="distances.xyz", action="write", status="new")
    
    ! skipping the first 2 not uselful lines
    do j=1,10
        read(1, *) skip_int
        read(1, *) skip_text, skip_text, skip_text
            do i=1,1000
                ! reading carbon atom
                read(1, *) skip_text, c_xyz(1), c_xyz(2),c_xyz(3)
                ! for 1st oxygen atom
                read(1, *) skip_text, o_xyz(1), o_xyz(2),o_xyz(3)
                dist = (((c_xyz(1) - o_xyz(1))**2) + ((c_xyz(2) - o_xyz(2))**2) + ((c_xyz(3) - o_xyz(3))**2))**0.5
                write(2,*) dist
                
                ! for 2nd oxgen atom
                read(1, *) skip_text, o_xyz(1), o_xyz(2),o_xyz(3)
                dist = (((c_xyz(1) - o_xyz(1))**2) + ((c_xyz(2) - o_xyz(2))**2) + ((c_xyz(3) - o_xyz(3))**2))**0.5
                write(2,*) dist
            end do
    end do



end program test